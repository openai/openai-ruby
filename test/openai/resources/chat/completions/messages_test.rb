# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Chat::Completions::MessagesTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.chat.completions.messages.list("completion_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Chat::ChatCompletionStoreMessage
    end
  end
end
