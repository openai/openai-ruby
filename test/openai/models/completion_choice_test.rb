# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Models::CompletionChoiceTest < Minitest::Test
  def test_finish_reason_can_be_nil_while_a_completion_is_streaming
    choice = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::CompletionChoice,
      {finish_reason: nil, index: 0, logprobs: nil, text: "partial"},
      state: OpenAI::Internal::Type::Converter.new_coerce_state
    )

    assert_nil(choice.finish_reason)
  end
end
