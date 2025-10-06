# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::ChatKit::ThreadsTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.beta.chatkit.threads.retrieve("cthr_123")

    assert_pattern do
      response => OpenAI::Beta::ChatKit::ChatKitThread
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        object: Symbol,
        status: OpenAI::Beta::ChatKit::ChatKitThread::Status,
        title: String | nil,
        user: String
      }
    end
  end

  def test_list
    response = @openai.beta.chatkit.threads.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::ChatKit::ChatKitThread
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        object: Symbol,
        status: OpenAI::Beta::ChatKit::ChatKitThread::Status,
        title: String | nil,
        user: String
      }
    end
  end

  def test_delete
    response = @openai.beta.chatkit.threads.delete("cthr_123")

    assert_pattern do
      response => OpenAI::Models::Beta::ChatKit::ThreadDeleteResponse
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end

  def test_list_items
    response = @openai.beta.chatkit.threads.list_items("cthr_123")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data
    end

    assert_pattern do
      case row
      in OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem
      in OpenAI::Beta::ChatKit::ChatKitThreadAssistantMessageItem
      in OpenAI::Beta::ChatKit::ChatKitWidgetItem
      in OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall
      in OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask
      in OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup
      end
    end

    assert_pattern do
      case row
      in {
        type: :"chatkit.user_message",
        id: String,
        attachments: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitAttachment]),
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content]),
        created_at: Integer,
        inference_options: OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions | nil,
        object: Symbol,
        thread_id: String
      }
      in {
        type: :"chatkit.assistant_message",
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitResponseOutputText]),
        created_at: Integer,
        object: Symbol,
        thread_id: String
      }
      in {type: :"chatkit.widget", id: String, created_at: Integer, object: Symbol, thread_id: String, widget: String}
      in {
        type: :"chatkit.client_tool_call",
        id: String,
        arguments: String,
        call_id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        output: String | nil,
        status: OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status,
        thread_id: String
      }
      in {
        type: :"chatkit.task",
        id: String,
        created_at: Integer,
        heading: String | nil,
        object: Symbol,
        summary: String | nil,
        task_type: OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType,
        thread_id: String
      }
      in {
        type: :"chatkit.task_group",
        id: String,
        created_at: Integer,
        object: Symbol,
        tasks: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task]),
        thread_id: String
      }
      end
    end
  end
end
