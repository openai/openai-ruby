# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesToolModelTest < Minitest::Test
  class LegacyToolModel < OpenAI::Internal::Type::BaseModel
    def self.to_json_schema = {type: "object"}
  end

  class ResponsesProbe < OpenAI::Resources::Responses
    def convert_tools(tools)
      get_structured_output_models(tools: tools)
    end
  end

  def test_legacy_model_tool_is_converted_in_place
    [nil, "explicit_name"].each do |name|
      function = {parameters: LegacyToolModel}
      function[:name] = name if name
      tool = {type: :function, function: function}
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.convert_tools(tools)

      assert_nil(model)
      assert_equal({(name || "LegacyToolModel") => LegacyToolModel}, tool_models)
      assert_equal({type: "object"}, function[:parameters])
      assert_same(tool, tools.first)
    end
  end

  def test_non_model_parameters_are_left_untouched
    [nil, {}, String, OpenAI::Internal::Type::BaseModel].each do |parameters|
      function = {parameters: parameters}
      tool = {type: :function, function: function}
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.convert_tools(tools)

      assert_nil(model)
      assert_empty(tool_models)
      assert_same(parameters, function[:parameters])
      assert_same(tool, tools.first)
    end
  end
end
