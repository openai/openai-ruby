# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Models::Realtime::RealtimeSessionCreateRequestTest < Minitest::Test
  def test_max_output_tokens_inf_ignores_rejected_integer_errors
    [:inf, "inf"].each do |input|
      request = OpenAI::Realtime::RealtimeSessionCreateRequest.new(max_output_tokens: input)

      assert_same(input, request.max_output_tokens)
      assert_same(input, request[:max_output_tokens])
      assert_same(input, request.to_h.fetch(:max_output_tokens))

      state = OpenAI::Internal::Type::Converter.new_coerce_state
      parsed = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Realtime::RealtimeSessionCreateRequest,
        {type: "realtime", max_output_tokens: input},
        state: state
      )

      assert_equal(:inf, parsed.max_output_tokens)
      assert_equal(:inf, parsed[:max_output_tokens])
      assert_nil(state.fetch(:error))
    end
  end
end
