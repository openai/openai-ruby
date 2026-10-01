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
    assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) do
      changed = OpenAI::Helpers::Beta::Agents::TurnResult.new(
        turn: result.turn,
        messages: [
          OpenAI::Models::Beta::AgentSessionMessage.new(
            id: "invalid",
            role: :assistant,
            status: :completed,
            phase: :final_answer,
            turn_id: result.turn_id,
            content: [{type: :output_text, text: text.sub("\"yes\"", "\"maybe\""), annotations: []}]
          )
        ]
      )
      changed.parse(output_type: Alternatives)
    end
  end

  def test_unsupported_constraints_fail_before_sending_a_request
    configure(complete)
    assert_raises(ArgumentError) { typed_stream(creation: true, output_type: Constrained) }
    assert_empty(@server.requests)
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

  def test_parse_failures_preserve_raw_result_and_cause
    invalid = [
      "not json",
      "[]",
      "{\"summary\":\"Ready\"}",
      report_json.sub("\"score\":2", "\"score\":\"2\""),
      report_json.sub("\"summary\":\"Ready\"", "\"summary\":\"Ready\",\"extra\":true")
    ]
    [false, true].product(invalid).each do |creation, text|
      configure([turn("created"), answer_event(text), turn("completed"), idle])
      subject = typed_stream(creation: creation)
      error = assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { subject.get_final_result }
      assert_equal(:completed, error.raw_result.turn.status)
      assert_equal(text, error.raw_result.output_text)
      assert(error.cause)
      assert_same(error, assert_raises(OpenAI::Helpers::Beta::Agents::OutputParseError) { subject.get_final_result })
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
