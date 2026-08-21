# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatCompletionParserTest < Minitest::Test
  class TextModel < OpenAI::BaseModel
    required :value, String
  end

  class ToolModel < OpenAI::BaseModel
    required :argument, Integer
  end

  class CaptureClient
    def request(**options) = options
  end

  class CombinedModels < OpenAI::Resources::Chat::Completions
    def get_structured_output_models(_parsed) = [TextModel, {"known" => ToolModel}]
  end

  def test_response_format_forms_keep_their_precedence_over_tools
    forms = [
      {response_format: TextModel},
      {response_format: {type: :json_schema, json_schema: TextModel}},
      {
        response_format: {
          type: :json_schema,
          json_schema: {name: "explicit", strict: false, schema: TextModel}
        }
      }
    ]
    resource = OpenAI::Resources::Chat::Completions.allocate

    forms.each do |params|
      tools = [ToolModel]
      params[:tools] = tools
      original = params[:response_format]
      original_schema = original[:json_schema] if original.is_a?(Hash)

      model, tool_models = resource.get_structured_output_models(params)

      assert_same(TextModel, model)
      assert_empty(tool_models)
      assert_same(tools, params[:tools])
      assert_same(ToolModel, tools.first)
      schema = params.fetch(:response_format).fetch(:json_schema)
      assert_equal(TextModel.to_json_schema, schema[:schema])
      assert_same(original, params[:response_format]) if original.is_a?(Hash)
      if original_schema.is_a?(Hash)
        assert_same(original_schema, schema)
        assert_equal("explicit", schema[:name])
        assert_equal(false, schema[:strict])
      else
        assert_equal("TextModel", schema[:name])
        assert_equal(true, schema[:strict])
      end
    end
  end

  def test_tool_conversion_preserves_names_and_input_identity
    [nil, "explicit"].each do |name|
      function = {parameters: ToolModel}
      function[:name] = name unless name.nil?
      nested = {type: :function, function: function}
      untouched = {type: :custom, custom: {name: "other"}}
      tools = [ToolModel, nested, untouched]

      model, tool_models = OpenAI::Resources::Chat::Completions
        .allocate
        .get_structured_output_models(tools: tools)

      assert_nil(model)
      assert_equal(
        {"ToolModel" => ToolModel, (name || "ToolModel") => ToolModel},
        tool_models
      )
      assert_equal(
        {
          type: :function,
          function: {strict: true, name: "ToolModel", parameters: ToolModel.to_json_schema}
        },
        tools.first
      )
      assert_same(nested, tools[1])
      assert_same(function, nested[:function])
      assert_equal(name || "ToolModel", function[:name])
      assert_equal(ToolModel.to_json_schema, function[:parameters])
      assert_same(untouched, tools.last)
    end
  end

  def test_build_tools_only_copies_matching_symbol_function_tools
    resource = OpenAI::Resources::Chat::Completions.allocate
    known = {type: :function, function: {name: "known"}}
    unknown = {type: :function, function: {name: "unknown"}}
    string_type = {type: "function", function: {name: "known"}}
    other = {type: :custom}
    tools = [known, unknown, string_type, other]

    assert_empty(resource.build_tools_with_models(nil, {}))
    mapped = resource.build_tools_with_models(tools, {"known" => ToolModel})

    refute_same(tools, mapped)
    refute_same(known, mapped.first)
    assert_equal(known.merge(model: ToolModel), mapped.first)
    refute(known.key?(:model))
    [unknown, string_type, other].each_with_index do |tool, index|
      assert_same(tool, mapped[index + 1])
    end
  end

  def test_create_preserves_request_shape_and_unwrap_contract
    request = OpenAI::Resources::Chat::Completions.new(client: CaptureClient.new).create(
      messages: [{role: :user, content: "test"}],
      model: "gpt-4o-mini",
      response_format: TextModel,
      request_options: {extra_headers: {"X-Test" => "yes"}}
    )
    unwrap = request.fetch(:unwrap)
    message = {content: "{\"value\":\"hello\"}"}
    raw = {choices: [{message: message}]}

    assert_equal(:post, request[:method])
    assert_equal("chat/completions", request[:path])
    assert_equal(OpenAI::Chat::ChatCompletion, request[:model])
    assert_equal({bearer_auth: true}, request[:security])
    assert_equal({"X-Test" => "yes"}, request.dig(:options, :extra_headers))
    assert_equal(TextModel.to_json_schema, request.dig(:body, :response_format, :json_schema, :schema))
    assert_predicate(unwrap, :lambda?)
    assert_equal(1, unwrap.arity)
    assert_same(raw, unwrap.call(raw))
    assert_instance_of(TextModel, message[:parsed])
    assert_equal("hello", message[:parsed].value)
  end

  def test_reused_unwrap_retains_its_captured_model_state
    unwrap = combined_unwrap
    function = {name: "known", arguments: "{\"argument\":7}"}
    first_message = {content: "{\"value\":\"first\"}", tool_calls: [{function: function}]}
    first = {choices: [{message: first_message}]}

    assert_same(first, unwrap.call(first))
    assert_instance_of(TextModel, first_message[:parsed])
    assert_instance_of(ToolModel, function[:parsed])
    assert_equal(7, function[:parsed].argument)

    second_message = {
      content: "{\"argument\":8}",
      tool_calls: [{function: {name: "unknown", arguments: "invalid"}}]
    }
    unwrap.call(choices: [{message: second_message}])
    assert_instance_of(ToolModel, second_message[:parsed])
    assert_equal(8, second_message[:parsed].argument)

    third_message = {content: "not json"}
    unwrap.call(choices: [{message: third_message}])
    refute(third_message.key?(:parsed))
  end

  def test_unwrap_preserves_nil_malformed_json_and_missing_key_behavior
    [nil, "not json"].each do |value|
      function = {name: "known", arguments: value}
      message = {content: value, tool_calls: [{function: function}]}
      raw = {choices: [{message: message}]}

      assert_same(raw, combined_unwrap.call(raw))
      if value.nil?
        assert_nil(message[:parsed])
        assert_nil(function[:parsed])
      else
        assert_instance_of(JSON::ParserError, message[:parsed])
        assert_instance_of(JSON::ParserError, function[:parsed])
      end
    end

    [
      [{choices: [{}]}, :message],
      [{choices: [{message: {}}]}, :content],
      [{choices: [{message: {content: nil, tool_calls: [{}]}}]}, :function],
      [{choices: [{message: {content: nil, tool_calls: [{function: {}}]}}]}, :name],
      [
        {choices: [{message: {content: nil, tool_calls: [{function: {name: "known"}}]}}]},
        :arguments
      ]
    ].each do |raw, key|
      error = assert_raises(KeyError) { combined_unwrap.call(raw) }
      assert_equal(key, error.key)
    end
  end

  def test_existing_resource_helper_parameters_and_visibility_are_unchanged
    resource = OpenAI::Resources::Chat::Completions

    assert_includes(resource.public_instance_methods, :get_structured_output_models)
    assert_includes(resource.public_instance_methods, :build_tools_with_models)
    assert_equal([[:req, :parsed]], resource.instance_method(:get_structured_output_models).parameters)
    assert_equal(
      [[:req, :tools], [:req, :tool_models]],
      resource.instance_method(:build_tools_with_models).parameters
    )
  end

  private def combined_unwrap
    CombinedModels
      .new(client: CaptureClient.new)
      .create(
        messages: [{role: :user, content: "test"}],
        model: "gpt-4o-mini"
      )
      .fetch(:unwrap)
  end
end
