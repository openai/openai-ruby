# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Chat::Completions::MessagesTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.chat.completions.messages.list("completion_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Chat::ChatCompletionStoreMessage
    end
  end
end
