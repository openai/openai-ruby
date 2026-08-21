# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Models::Realtime::RealtimeMcpListToolsTest < Minitest::Test
  def test_tool_errors_do_not_depend_on_collection_order
    invalid = {input_schema: {}, name: Object.new}
    valid = {input_schema: {}, name: "lookup"}

    [[invalid, valid], [valid, invalid]].each do |tools|
      request = OpenAI::Realtime::RealtimeMcpListTools.new(server_label: "server", tools: tools)

      assert_same(tools, request[:tools])
      assert_same(tools, request.to_h.fetch(:tools))
      request_error = assert_raises(OpenAI::Errors::ConversionError) { request.tools }
      assert_instance_of(TypeError, request_error.cause)

      state = OpenAI::Internal::Type::Converter.new_coerce_state
      parsed = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Realtime::RealtimeMcpListTools,
        {server_label: "server", tools: tools},
        state: state
      )

      parsed_tools = parsed[:tools]
      assert(parsed_tools.all? { _1.is_a?(OpenAI::Realtime::RealtimeMcpListTools::Tool) })
      assert_same(parsed_tools, parsed.to_h.fetch(:tools))
      assert_instance_of(TypeError, state.fetch(:error))
      assert_match(/Object can't be coerced into String/, state.fetch(:error).message)
    end
  end
end
