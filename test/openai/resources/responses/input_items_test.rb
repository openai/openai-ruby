# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Responses::InputItemsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.responses.input_items.list("response_id")

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    assert_pattern do
      row => OpenAI::Models::Responses::ResponseItemList::Data
    end

    assert_pattern do
      case row
      in OpenAI::Models::Responses::ResponseItemList::Data::Message
      in OpenAI::Models::Responses::ResponseOutputMessage
      in OpenAI::Models::Responses::ResponseFileSearchToolCall
      in OpenAI::Models::Responses::ResponseComputerToolCall
      in OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput
      in OpenAI::Models::Responses::ResponseFunctionWebSearch
      in OpenAI::Models::Responses::ResponseFunctionToolCall
      in OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
      end
    end

    assert_pattern do
      case row
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputContent]),
        role: OpenAI::Models::Responses::ResponseItemList::Data::Message::Role,
        status: OpenAI::Models::Responses::ResponseItemList::Data::Message::Status | nil
      }
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputMessage::Content]),
        role: Symbol,
        status: OpenAI::Models::Responses::ResponseOutputMessage::Status
      }
      in {
        type: :file_search_call,
        id: String,
        queries: ^(OpenAI::ArrayOf[String]),
        status: OpenAI::Models::Responses::ResponseFileSearchToolCall::Status,
        results: ^(OpenAI::ArrayOf[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]) | nil
      }
      in {
        type: :computer_call,
        id: String,
        action: OpenAI::Models::Responses::ResponseComputerToolCall::Action,
        call_id: String,
        pending_safety_checks: ^(OpenAI::ArrayOf[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck]),
        status: OpenAI::Models::Responses::ResponseComputerToolCall::Status
      }
      in {
        type: :computer_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output,
        acknowledged_safety_checks: ^(OpenAI::ArrayOf[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck]) | nil,
        status: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Status | nil
      }
      in {type: :web_search_call, id: String, status: OpenAI::Models::Responses::ResponseFunctionWebSearch::Status}
      in {
        type: :function_call,
        arguments: String,
        call_id: String,
        name: String,
        id: String | nil,
        status: OpenAI::Models::Responses::ResponseFunctionToolCall::Status | nil
      }
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: String,
        status: OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput::Status | nil
      }
      end
    end
  end
end
