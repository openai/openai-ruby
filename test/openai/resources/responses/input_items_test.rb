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
      in OpenAI::Responses::ResponseItem::ImageGenerationCall
      in OpenAI::Responses::ResponseCodeInterpreterToolCall
      in OpenAI::Responses::ResponseItem::LocalShellCall
      in OpenAI::Responses::ResponseItem::LocalShellCallOutput
      in OpenAI::Responses::ResponseFunctionShellToolCall
      in OpenAI::Responses::ResponseFunctionShellToolCallOutput
      in OpenAI::Responses::ResponseApplyPatchToolCall
      in OpenAI::Responses::ResponseApplyPatchToolCallOutput
      in OpenAI::Responses::ResponseItem::McpListTools
      in OpenAI::Responses::ResponseItem::McpApprovalRequest
      in OpenAI::Responses::ResponseItem::McpApprovalResponse
      in OpenAI::Responses::ResponseItem::McpCall
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
      in {
        type: :web_search_call,
        id: String,
        action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
        status: OpenAI::Responses::ResponseFunctionWebSearch::Status
      }
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Output,
        status: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Status | nil
      }
      in {
        type: :image_generation_call,
        id: String,
        result: String | nil,
        status: OpenAI::Responses::ResponseItem::ImageGenerationCall::Status
      }
      in {
        type: :code_interpreter_call,
        id: String,
        code: String | nil,
        container_id: String,
        outputs: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseCodeInterpreterToolCall::Output]) | nil,
        status: OpenAI::Responses::ResponseCodeInterpreterToolCall::Status
      }
      in {
        type: :local_shell_call,
        id: String,
        action: OpenAI::Responses::ResponseItem::LocalShellCall::Action,
        call_id: String,
        status: OpenAI::Responses::ResponseItem::LocalShellCall::Status
      }
      in {
        type: :local_shell_call_output,
        id: String,
        output: String,
        status: OpenAI::Responses::ResponseItem::LocalShellCallOutput::Status | nil
      }
      in {
        type: :shell_call,
        id: String,
        action: OpenAI::Responses::ResponseFunctionShellToolCall::Action,
        call_id: String,
        status: OpenAI::Responses::ResponseFunctionShellToolCall::Status,
        created_by: String | nil
      }
      in {
        type: :shell_call_output,
        id: String,
        call_id: String,
        max_output_length: Integer | nil,
        output: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFunctionShellToolCallOutput::Output]),
        created_by: String | nil
      }
      in {
        type: :apply_patch_call,
        id: String,
        call_id: String,
        operation: OpenAI::Responses::ResponseApplyPatchToolCall::Operation,
        status: OpenAI::Responses::ResponseApplyPatchToolCall::Status,
        created_by: String | nil
      }
      in {
        type: :apply_patch_call_output,
        id: String,
        call_id: String,
        status: OpenAI::Responses::ResponseApplyPatchToolCallOutput::Status,
        created_by: String | nil,
        output: String | nil
      }
      in {
        type: :mcp_list_tools,
        id: String,
        server_label: String,
        tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseItem::McpListTools::Tool]),
        error: String | nil
      }
      in {type: :mcp_approval_request, id: String, arguments: String, name: String, server_label: String}
      in {
        type: :mcp_approval_response,
        id: String,
        approval_request_id: String,
        approve: OpenAI::Internal::Type::Boolean,
        reason: String | nil
      }
      in {
        type: :mcp_call,
        id: String,
        arguments: String,
        name: String,
        server_label: String,
        approval_request_id: String | nil,
        error: String | nil,
        output: String | nil,
        status: OpenAI::Responses::ResponseItem::McpCall::Status | nil
      }
      end
    end
  end
end
