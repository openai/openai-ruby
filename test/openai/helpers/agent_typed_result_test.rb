# frozen_string_literal: true

require_relative "agent_turn_result_test"

class OpenAI::Test::AgentTypedResultTest < OpenAI::Test::AgentTurnResultTest
  class Finding < OpenAI::BaseModel
    required :label, String
    required :score, Integer
  end

  class Report < OpenAI::BaseModel
    required :summary, String
    required :findings, OpenAI::ArrayOf[Finding]
    required :question, String, nil?: true
  end

  class Tree < OpenAI::BaseModel
    required :label, String
    required :children, -> { OpenAI::ArrayOf[Tree] }
  end

  class Alternatives < OpenAI::BaseModel
    required :choice, OpenAI::EnumOf[:yes, :no]
    required :detail, OpenAI::UnionOf[String, Integer]
    required :first, Finding, doc: "Primary finding"
    required :second, Finding, doc: "Secondary finding"
  end

  class Constrained < OpenAI::BaseModel
    required :name, String, minLength: 2
  end

  def test_enums_unions_and_reused_nested_models
    text = JSON.generate(choice: "yes", detail: 3, first: {label: "A", score: 1}, second: {label: "B", score: 2})
    configure([turn("created"), answer_event(text), turn("completed"), idle])
    result = typed_stream(creation: true, output_type: Alternatives).get_final_result
    assert_equal(:yes, result.output_parsed.choice)
    assert_equal(3, result.output_parsed.detail)
    assert_equal("B", result.output_parsed.second.label)
  end

  def test_supported_constraints_are_preserved_for_hosted_validation
    configure(complete)
    parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(Constrained)
    params = {agent: {model: "test-model"}}
    parser.prepare_request(params)
    assert_equal(2, params.dig(:agent, :text, :format, :schema, "properties", "name", "minLength"))
  end

  class BranchA < OpenAI::BaseModel
    required :child, -> { OpenAI::UnionOf[BranchA, BranchB] }, nil?: true
    required :kind, const: :a
  end

  class BranchB < OpenAI::BaseModel
    required :child, -> { OpenAI::UnionOf[BranchA, BranchB] }, nil?: true
    required :kind, const: :b
  end

  class BranchReport < OpenAI::BaseModel
    required :branch, OpenAI::UnionOf[BranchA, BranchB]
  end

  def test_recursive_union_hydration_does_not_repeat_subtrees
    ["invalid", "b"].each do |kind|
      value = nil
      16.times { value = {child: value, kind: kind} }
      configure([turn("created"), answer_event(JSON.generate(branch: value)), turn("completed"), idle])
      raw = stream.get_final_result
      parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(BranchReport)
      calls = 0
      trace = TracePoint.new(:call) { calls += 1 if _1.method_id == :coerce }
      parsed = trace.enable { parser.parse(raw).output_parsed }
      assert_operator(calls, :<, 1000)
      assert_instance_of(BranchB, parsed.branch) if kind == "b"
    end
  end

  def test_memoized_conversion_preserves_native_union_selection_and_state
    values = [
      {branch: {child: nil, kind: "b"}},
      {branch: {child: {child: nil, kind: "b"}, kind: "invalid"}},
      {branch: []}
    ]
    values.each do |value|
      native = OpenAI::Internal::Type::Converter.new_coerce_state
      memoized = OpenAI::Internal::Type::Converter.new_coerce_state(memoize: true)
      expected = OpenAI::Internal::Type::Converter.coerce(BranchReport, value, state: native)
      actual = OpenAI::Internal::Type::Converter.coerce(BranchReport, value, state: memoized)
      assert_equal(expected, actual)
      assert_equal(native.except(:memo, :error), memoized.except(:memo, :error))
      assert_equal([native[:error]&.class], [memoized[:error]&.class])
    end
  end

  class AnnotatedRecursive < OpenAI::BaseModel
    required :child, -> { AnnotatedRecursive }, doc: "Next node"
  end

  def test_reference_names_are_normalized_for_agents_strict_schema
    inner = Class.new(OpenAI::BaseModel) { required(:label, String) }
    outer = Class.new(OpenAI::BaseModel) do
      required(:first, inner)
      required(:second, inner)
    end

    report = Class.new(OpenAI::BaseModel) { required(:outer, outer) }
    [report, Tree, AnnotatedRecursive].each do |model|
      parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(model)
      params = {agent: {model: "test-model"}}
      parser.prepare_request(params)
      schema = params.dig(:agent, :text, :format, :schema)
      definitions = schema.fetch("$defs")
      assert(definitions.keys.all? { _1.match?(/\Amodel_\d+\z/) })
      nodes = [schema]
      until nodes.empty?
        node = nodes.pop
        case node
        when Hash
          if node.key?("$ref")
            assert(definitions.key?(node.fetch("$ref").delete_prefix("#/$defs/")))
            assert_equal(["$ref"], node.keys)
          end

          nodes.concat(node.values)
        when Array
          nodes.concat(node)
        end
      end
    end
  end

  def test_schema_copy_does_not_add_a_json_nesting_limit
    model = Class.new(OpenAI::BaseModel) { required(:leaf, String) }
    60.times do
      inner = model
      model = Class.new(OpenAI::BaseModel) { required(:child, inner) }
    end

    parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(model)
    params = {agent: {model: "test-model"}}
    parser.prepare_request(params)
    assert_equal("object", params.dig(:agent, :text, :format, :schema, "type"))
  end

  def test_string_keyed_agent_configuration_preserves_options_and_detects_conflicts
    parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(Report)
    params = {agent: {"model" => "test-model", "text" => {"verbosity" => "low"}}}
    parser.prepare_request(params)
    assert_equal("test-model", params.dig(:agent, :model))
    assert_equal("low", params.dig(:agent, :text, :verbosity))
    assert_raises(ArgumentError) do
      parser.prepare_request(agent: {"text" => {"format" => {"type" => "text"}}})
    end
  end

  def test_schema_normalization_does_not_interpret_business_property_names_or_defaults
    model = Class.new(OpenAI::BaseModel) do
      required(:reference, String, api_name: :$ref, default: {"$ref" => "business value"})
    end

    parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(model)
    params = {agent: {model: "test-model"}}
    parser.prepare_request(params)
    field = params.dig(:agent, :text, :format, :schema, "properties", "$ref")
    assert_equal("string", field.fetch("type"))
    assert_equal({"$ref" => "business value"}, field.fetch("default"))
  end

  def test_typed_tools_and_results_share_native_model_conventions
    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "summarize", arguments: Report) { _1 }
    configure([turn("created"), answer_event(report_json), turn("completed"), idle])
    parsed = typed_stream.get_final_result.output_parsed
    assert_equal(tool.call(report_json), parsed)
    assert_instance_of(Finding, parsed.findings.first)
  end

  def test_recursive_collection_unions_reuse_conversion_work
    union = nil
    left = OpenAI::ArrayOf[-> { union }]
    right = OpenAI::ArrayOf[-> { union }]
    union = OpenAI::UnionOf[left, right, Integer]
    model = Class.new(OpenAI::BaseModel) { required(:value, union) }
    [false, 1].each do |leaf|
      value = leaf
      16.times { value = [value] }
      configure([turn("created"), answer_event(JSON.generate(value: value)), turn("completed"), idle])
      raw = stream.get_final_result
      parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(model)
      calls = 0
      trace = TracePoint.new(:call) { calls += 1 if _1.method_id == :coerce }
      trace.enable do
        if leaf == false
          assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { parser.parse(raw) }
        else
          assert_instance_of(model, parser.parse(raw).output_parsed)
        end
      end

      assert_operator(calls, :<, 1000)
    end
  end

  def test_supported_creation_parameter_containers_keep_output_type_local
    [
      OpenAI::Beta::Agents::SessionCreateParams.new(
        agent: {model: "test-model"},
        environment: {type: :none},
        input: "Report"
      ),
      {
        "agent" => {"model" => "test-model"},
        "environment" => {"type" => "none"},
        "input" => "Report",
        "output_type" => Report
      }
    ].each do |params|
      configure([turn("created"), answer_event(report_json), turn("completed"), idle])
      result = @sessions.create_streaming(params).get_final_result
      assert_equal(report_json, result.output_text)
      assert_instance_of(Report, result.output_parsed) if params.is_a?(Hash)
      body = JSON.parse(@server.requests.first.body)
      refute(body.key?("output_type"))
    end
  end

  def test_numeric_range_failure_preserves_raw_result
    configure(
      [turn("created"), answer_event(report_json.sub("\"score\":2", "\"score\":1e400")), turn("completed"), idle]
    )
    error = assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { typed_stream.get_final_result }
    assert_includes(error.raw_result.output_text, "1e400")
    assert_nil(error.cause)
  end

  def test_recursive_output_is_not_limited_to_100_json_levels
    tree = {label: "leaf", children: []}
    80.times { tree = {label: "parent", children: [tree]} }
    configure([turn("created"), answer_event(JSON.generate(tree, max_nesting: false)), turn("completed"), idle])
    result = typed_stream(output_type: Tree).get_final_result
    parsed = result.output_parsed
    80.times { parsed = parsed.children.first }
    assert_equal("leaf", parsed.label)
  end

  def report_json = JSON.generate(summary: "Ready", findings: [{label: "A", score: 2}], question: nil)

  def typed_stream(creation: false, output_type: Report)
    if creation
      @sessions.create_streaming(
        agent: {model: "test-model"},
        environment: {type: :none},
        input: "Report",
        output_type: output_type
      )
    else
      @sessions.stream("session_test", input: "Report", output_type: output_type)
    end
  end

  def test_typed_creation_and_followup_preserve_raw_result_and_cache
    [false, true].each do |creation|
      configure([turn("created"), answer_event(report_json), turn("completed"), idle])
      result_stream = typed_stream(creation: creation)
      result = result_stream.get_final_result
      assert_instance_of(Report, result.output_parsed)
      assert_equal("Ready", result.output_parsed.summary)
      assert_instance_of(Finding, result.output_parsed.findings.first)
      assert_equal(2, result.output_parsed.findings.first.score)
      assert_nil(result.output_parsed.question)
      assert_equal(report_json, result.output_text)
      assert_same(result.messages, result.raw_result.messages)
      assert_same(result, result_stream.get_final_result)
      bodies = @server.requests.select { _1.method == :post }.map { JSON.parse(_1.body) }
      refute(bodies.any? { _1.key?("output_type") })
      if creation
        format = bodies.first.dig("agent", "text", "format")
        assert_equal(%w[schema type], format.keys.sort)
        assert_equal("json_schema", format["type"])
        assert_equal("object", format.dig("schema", "type"))
      else
        assert_equal(1, bodies.length)
        refute(bodies.first.key?("agent"))
      end
    end
  end

  def test_parse_failures_preserve_raw_result_without_unsafe_causes
    invalid = [
      "not json",
      "[]",
      "{\"summary\":\"Ready\"}",
      report_json.sub("\"score\":2", "\"score\":[]")
    ]
    [false, true].product(invalid).each do |creation, text|
      configure([turn("created"), answer_event(text), turn("completed"), idle])
      subject = typed_stream(creation: creation)
      error = assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { subject.get_final_result }
      assert_equal(:completed, error.raw_result.turn.status)
      assert_equal(text, error.raw_result.output_text)
      assert_nil(error.cause)
      assert_same(error, assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { subject.get_final_result })
    end
  end

  class EmptyEnum < OpenAI::BaseModel
    required :value, OpenAI::EnumOf[]
  end

  class URIReport < OpenAI::BaseModel
    required :link, String, format: "uri"
  end

  def test_unsupported_string_formats_fail_before_creation_network
    configure(complete)
    assert_raises(ArgumentError) { typed_stream(creation: true, output_type: URIReport) }
    assert_empty(@server.requests)
  end

  def test_followup_and_raw_parsing_do_not_require_an_installable_agents_schema
    text = JSON.generate(link: "https://example.com")
    configure([turn("created"), answer_event(text), turn("completed"), idle])
    result = typed_stream(output_type: URIReport).get_final_result
    assert_equal("https://example.com", result.output_parsed.link)
    assert_equal(result.output_parsed, result.raw_result.parse(output_type: URIReport).output_parsed)
  end

  def test_empty_enums_fail_before_network
    configure(complete)
    assert_raises(ArgumentError) { typed_stream(creation: true, output_type: EmptyEnum) }
    assert_empty(@server.requests)
  end

  def test_integral_json_numbers_hydrate_as_integers
    %w[1.0 1e0].each do |number|
      text = report_json.sub("\"score\":2", "\"score\":#{number}")
      configure([turn("created"), answer_event(text), turn("completed"), idle])
      score = typed_stream.get_final_result.output_parsed.findings.first.score
      assert_instance_of(Integer, score)
      assert_equal(1, score)
    end
  end

  def test_parse_error_tracebacks_do_not_include_output
    canary = "PRIVATE_SYNTHETIC_REPORT_CANARY"
    configure([turn("created"), answer_event("#{canary} invalid JSON"), turn("completed"), idle])
    subject = typed_stream
    2.times do
      error = assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { subject.get_final_result }
      refute_includes(error.full_message, canary)
      assert_includes(error.raw_result.output_text, canary)
    end
  end

  def test_hosted_failures_are_not_parse_errors
    configure([turn("created"), turn("failed"), idle])
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { typed_stream.get_final_result }
    assert_equal(:failed, error.reason)
  end

  def test_recursive_models_and_explicit_raw_result_parse
    text = JSON.generate(label: "root", children: [{label: "child", children: []}])
    configure([turn("created"), answer_event(text), turn("completed"), idle])
    result = typed_stream(creation: true, output_type: Tree).get_final_result
    assert_instance_of(Tree, result.output_parsed.children.first)
    assert_equal("child", result.output_parsed.children.first.label)
    assert_instance_of(Tree, result.raw_result.parse(output_type: Tree).output_parsed)
    request = JSON.parse(@server.requests.first.body)
    assert_equal("object", request.dig("agent", "text", "format", "schema", "type"))
  end

  def test_type_validation_precedes_network_and_rejects_conflicting_schema
    configure(complete)
    assert_raises(ArgumentError) { typed_stream(creation: true, output_type: String) }
    assert_empty(@server.requests)
    assert_raises(ArgumentError) do
      @sessions.create_streaming(
        agent: {model: "test-model", text: {format: {type: :text}}},
        environment: {type: :none},
        input: "Report",
        output_type: Report
      )
    end

    assert_empty(@server.requests)
  end

  def test_raw_iteration_keeps_collection_opt_in_for_typed_streams
    configure([turn("created"), answer_event(report_json), turn("completed"), idle])
    subject = typed_stream(creation: true)
    subject.each { |_event| nil }
    assert_empty(subject.instance_variable_get(:@collector).instance_variable_get(:@messages))
    assert_raises(ArgumentError) { subject.get_final_result }
  end
end
