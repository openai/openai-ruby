# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ConversationsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.conversations.create

    assert_pattern do
      response => OpenAI::Conversations::Conversation
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: OpenAI::Internal::Type::Unknown,
        object: Symbol
      }
    end
  end

  def test_retrieve
    response = @openai.conversations.retrieve("conv_123")

    assert_pattern do
      response => OpenAI::Conversations::Conversation
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: OpenAI::Internal::Type::Unknown,
        object: Symbol
      }
    end
  end

  def test_update_required_params
    response = @openai.conversations.update("conv_123", metadata: {foo: "string"})

    assert_pattern do
      response => OpenAI::Conversations::Conversation
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: OpenAI::Internal::Type::Unknown,
        object: Symbol
      }
    end
  end

  def test_delete
    response = @openai.conversations.delete("conv_123")

    assert_pattern do
      response => OpenAI::Conversations::ConversationDeletedResource
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
