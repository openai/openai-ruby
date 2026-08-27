# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponseParserTest < Minitest::Test
  class TextModel < OpenAI::BaseModel
    required :value, String
  end

  class ToolModel < OpenAI::BaseModel
    required :argument, Integer
  end

  class ResponsesProbe < OpenAI::Resources::Responses
    def prepare(parsed) = get_structured_output_models(parsed)

    def parse(raw, model, tool_models) = parse_structured_outputs!(raw, model, tool_models)
  end

  def test_all_text_forms_prepare_tools_and_preserve_nested_objects
    forms = [
      {text: TextModel},
      {text: {format: TextModel, verbosity: :low}},
      {text: {format: {type: :json_schema, name: "explicit", strict: false, schema: TextModel}}}
    ]

    forms.each do |params|
      original_text = params[:text]
      original_format = original_text[:format] if original_text.is_a?(Hash)
      tools = [ToolModel]
      params[:tools] = tools

      model, tool_models = ResponsesProbe.allocate.prepare(params)

      assert_same(TextModel, model)
      assert_equal({"ToolModel" => ToolModel}, tool_models)
      assert_same(tools, params[:tools])
      assert_equal(
        [{type: :function, strict: true, name: "ToolModel", parameters: ToolModel.to_json_schema}],
        tools
      )
      format = params.fetch(:text).fetch(:format)
      assert_equal(TextModel.to_json_schema, format[:schema])
      if original_text.is_a?(Hash)
        assert_same(original_text, params[:text])
      end

      if original_format.is_a?(Hash)
        assert_same(original_format, format)
        assert_equal("explicit", format[:name])
        assert_equal(false, format[:strict])
      else
        assert_equal("TextModel", format[:name])
        assert_equal(true, format[:strict])
      end
    end
  end

  def test_nested_tool_names_and_flat_tool_behavior_are_preserved
    [nil, "explicit"].each do |name|
      function = {parameters: ToolModel}
      function[:name] = name unless name.nil?
      tool = {type: :function, function: function}
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.prepare(tools: tools)

      assert_nil(model)
      assert_equal({(name || "ToolModel") => ToolModel}, tool_models)
      assert_same(tool, tools.first)
      assert_same(function, tool[:function])
      assert_equal(ToolModel.to_json_schema, function[:parameters])
      assert_equal(name, function[:name]) unless name.nil?
      refute(function.key?(:name)) if name.nil?
    end

    function = {}
    tool = {type: :function, parameters: ToolModel, function: function}
    _model, tool_models = ResponsesProbe.allocate.prepare(tools: [tool])
    assert_equal({"ToolModel" => ToolModel}, tool_models)
    assert_equal("ToolModel", function[:name])
    assert_equal(ToolModel.to_json_schema, function[:parameters])
    assert_same(ToolModel, tool[:parameters])
  end

  def test_flat_converter_preserves_tool_fields_and_infers_missing_names
    [nil, "explicit"].each do |name|
      tool = {type: :function, strict: false, description: "A tool", parameters: ToolModel}
      tool[:name] = name unless name.nil?
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.prepare(tools: tools)

      assert_nil(model)
      assert_equal({(name || "ToolModel") => ToolModel}, tool_models)
      assert_same(tool, tools.first)
      assert_equal(name || "ToolModel", tool[:name])
      assert_equal(false, tool[:strict])
      assert_equal("A tool", tool[:description])
      assert_equal(ToolModel.to_json_schema, tool[:parameters])
      refute(tool.key?(:function))
    end
  end

  def test_parse_updates_known_outputs_in_place_and_leaves_other_types_alone
    text = {type: "output_text", text: "{\"value\":\"hello\"}"}
    refusal = {type: "refusal", refusal: "no"}
    symbol_text = {type: :output_text, text: "{\"value\":\"ignored\"}"}
    known_tool = {type: "function_call", name: "known", arguments: "{\"argument\":7}"}
    unknown_tool = {type: "function_call", name: "unknown", arguments: "invalid"}
    raw = {
      output: [
        {type: "message", content: [text, refusal, symbol_text]},
        {type: :message, content: [{type: "output_text", text: "invalid"}]},
        known_tool,
        unknown_tool
      ]
    }

    result = ResponsesProbe.allocate.parse(raw, TextModel, {"known" => ToolModel})

    assert_same(raw, result)
    assert_instance_of(TextModel, text[:parsed])
    assert_equal("hello", text[:parsed].value)
    assert_instance_of(ToolModel, known_tool[:parsed])
    assert_equal(7, known_tool[:parsed].argument)
    refute(refusal.key?(:parsed))
    refute(symbol_text.key?(:parsed))
    refute(unknown_tool.key?(:parsed))
    refute(raw[:output][1][:content][0].key?(:parsed))
  end

  def test_parse_preserves_malformed_json_and_missing_key_errors
    text = {type: "output_text", text: "not json"}
    tool = {type: "function_call", name: "known", arguments: "not json"}
    raw = {output: [{type: "message", content: [text]}, tool]}

    assert_same(raw, ResponsesProbe.allocate.parse(raw, TextModel, {"known" => ToolModel}))
    assert_instance_of(JSON::ParserError, text[:parsed])
    assert_instance_of(JSON::ParserError, tool[:parsed])

    [
      [{output: [{type: "message", content: [{type: "output_text"}]}]}, :text],
      [{output: [{type: "function_call"}]}, :name],
      [{output: [{type: "function_call", name: "known"}]}, :arguments]
    ].each do |payload, key|
      error = assert_raises(KeyError) do
        ResponsesProbe.allocate.parse(payload, TextModel, {"known" => ToolModel})
      end

      assert_equal(key, error.key)
    end
  end

  def test_empty_outputs_and_private_delegate_visibility_are_preserved
    [{}, {output: nil}, {output: []}].each do |raw|
      assert_same(raw, ResponsesProbe.allocate.parse(raw, nil, {}))
    end

    assert_includes(OpenAI::Resources::Responses.private_instance_methods, :get_structured_output_models)
    assert_includes(OpenAI::Resources::Responses.private_instance_methods, :parse_structured_outputs!)
    refute_includes(OpenAI::Resources::Responses.public_instance_methods, :get_structured_output_models)
    refute_includes(OpenAI::Resources::Responses.public_instance_methods, :parse_structured_outputs!)
  end
end
