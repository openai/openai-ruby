# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Threads::MessagesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.threads.messages.create("thread_id", content: "string", role: :user)

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Message
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String | nil,
        attachments: ^(OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment]) | nil,
        completed_at: Integer | nil,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent]),
        created_at: Integer,
        incomplete_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Message::IncompleteDetails | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        role: OpenAI::Models::Beta::Threads::Message::Role,
        run_id: String | nil,
        status: OpenAI::Models::Beta::Threads::Message::Status,
        thread_id: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.beta.threads.messages.retrieve("message_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Message
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String | nil,
        attachments: ^(OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment]) | nil,
        completed_at: Integer | nil,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent]),
        created_at: Integer,
        incomplete_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Message::IncompleteDetails | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        role: OpenAI::Models::Beta::Threads::Message::Role,
        run_id: String | nil,
        status: OpenAI::Models::Beta::Threads::Message::Status,
        thread_id: String
      }
    end
  end

  def test_update_required_params
    response = @openai.beta.threads.messages.update("message_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Message
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String | nil,
        attachments: ^(OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment]) | nil,
        completed_at: Integer | nil,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent]),
        created_at: Integer,
        incomplete_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Message::IncompleteDetails | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        role: OpenAI::Models::Beta::Threads::Message::Role,
        run_id: String | nil,
        status: OpenAI::Models::Beta::Threads::Message::Status,
        thread_id: String
      }
    end
  end

  def test_list
    response = @openai.beta.threads.messages.list("thread_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Beta::Threads::Message
    end

    assert_pattern do
      row => {
        id: String,
        assistant_id: String | nil,
        attachments: ^(OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment]) | nil,
        completed_at: Integer | nil,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent]),
        created_at: Integer,
        incomplete_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Message::IncompleteDetails | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        role: OpenAI::Models::Beta::Threads::Message::Role,
        run_id: String | nil,
        status: OpenAI::Models::Beta::Threads::Message::Status,
        thread_id: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.beta.threads.messages.delete("message_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::MessageDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::BooleanModel,
        object: Symbol
      }
    end
  end
end
