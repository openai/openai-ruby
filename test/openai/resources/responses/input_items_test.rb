# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Responses::InputItemsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.responses.input_items.list("response_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Responses::ResponseItem
    end

    assert_pattern do
      case row
      in OpenAI::Responses::ResponseInputMessageItem
      in OpenAI::Responses::ResponseOutputMessage
      in OpenAI::Responses::ResponseFileSearchToolCall
      in OpenAI::Responses::ResponseComputerToolCall
      in OpenAI::Responses::ResponseComputerToolCallOutputItem
      in OpenAI::Responses::ResponseFunctionWebSearch
      in OpenAI::Responses::ResponseFunctionToolCallItem
      in OpenAI::Responses::ResponseFunctionToolCallOutputItem
      end
    end

    assert_pattern do
      case row
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseInputContent]),
        role: OpenAI::Responses::ResponseInputMessageItem::Role,
        status: OpenAI::Responses::ResponseInputMessageItem::Status | nil
      }
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseOutputMessage::Content]),
        role: Symbol,
        status: OpenAI::Responses::ResponseOutputMessage::Status
      }
      in {
        type: :file_search_call,
        id: String,
        queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
        status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
      }
      in {
        type: :computer_call,
        id: String,
        action: OpenAI::Responses::ResponseComputerToolCall::Action,
        call_id: String,
        pending_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseComputerToolCall::PendingSafetyCheck]),
        status: OpenAI::Responses::ResponseComputerToolCall::Status
      }
      in {
        type: :computer_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Responses::ResponseComputerToolCallOutputScreenshot,
        acknowledged_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck]) | nil,
        status: OpenAI::Responses::ResponseComputerToolCallOutputItem::Status | nil
      }
      in {type: :web_search_call, id: String, status: OpenAI::Responses::ResponseFunctionWebSearch::Status}
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: String,
        status: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Status | nil
      }
      end
    end
  end
end
