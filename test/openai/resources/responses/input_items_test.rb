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
      in (
        OpenAI::Responses::ResponseInputMessageItem | OpenAI::Responses::ResponseOutputMessage | OpenAI::Responses::ResponseFileSearchToolCall | OpenAI::Responses::ResponseComputerToolCall | OpenAI::Responses::ResponseComputerToolCallOutputItem | OpenAI::Responses::ResponseFunctionWebSearch | OpenAI::Responses::ResponseFunctionToolCallItem | OpenAI::Responses::ResponseFunctionToolCallOutputItem | OpenAI::Responses::ResponseToolSearchCall | OpenAI::Responses::ResponseToolSearchOutputItem | OpenAI::Responses::ResponseItem::AdditionalTools | OpenAI::Responses::ResponseReasoningItem | OpenAI::Responses::ResponseItem::Program | OpenAI::Responses::ResponseItem::ProgramOutput | OpenAI::Responses::ResponseCompactionItem | OpenAI::Responses::ResponseItem::ImageGenerationCall | OpenAI::Responses::ResponseCodeInterpreterToolCall | OpenAI::Responses::ResponseItem::LocalShellCall | OpenAI::Responses::ResponseItem::LocalShellCallOutput | OpenAI::Responses::ResponseFunctionShellToolCall | OpenAI::Responses::ResponseFunctionShellToolCallOutput | OpenAI::Responses::ResponseApplyPatchToolCall | OpenAI::Responses::ResponseApplyPatchToolCallOutput | OpenAI::Responses::ResponseItem::McpListTools | OpenAI::Responses::ResponseItem::McpApprovalRequest | OpenAI::Responses::ResponseItem::McpApprovalResponse | OpenAI::Responses::ResponseItem::McpCall | OpenAI::Responses::ResponseCustomToolCallItem | OpenAI::Responses::ResponseCustomToolCallOutputItem
      )
        nil
      end
    end

    assert_pattern do
      case row
      in (
        {
            type: :message,
            id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseInputContent]),
            role: OpenAI::Responses::ResponseInputMessageItem::Role,
            status: OpenAI::Responses::ResponseInputMessageItem::Status | nil
          } | {
            type: :message,
            id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseOutputMessage::Content]),
            role: Symbol,
            status: OpenAI::Responses::ResponseOutputMessage::Status,
            phase: OpenAI::Responses::ResponseOutputMessage::Phase | nil
          } | {
            type: :file_search_call,
            id: String,
            queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
            status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
            results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
          } | {
            type: :computer_call,
            id: String,
            call_id: String,
            pending_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[
              OpenAI::Responses::ResponseComputerToolCall::PendingSafetyCheck
            ]),
            status: OpenAI::Responses::ResponseComputerToolCall::Status,
            action: OpenAI::Responses::ResponseComputerToolCall::Action | nil,
            actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ComputerAction]) | nil
          } | {
            type: :computer_call_output,
            id: String,
            call_id: String,
            output: OpenAI::Responses::ResponseComputerToolCallOutputScreenshot,
            status: OpenAI::Responses::ResponseComputerToolCallOutputItem::Status,
            acknowledged_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[
              OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck
            ]) | nil,
            created_by: String | nil
          } | {
            type: :web_search_call,
            id: String,
            action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
            status: OpenAI::Responses::ResponseFunctionWebSearch::Status
          } | {
            type: :function_call_output,
            id: String,
            output: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Output,
            status: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Status,
            call_id: String | nil,
            caller_: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Caller | nil,
            created_by: String | nil,
            name: String | nil,
            namespace: String | nil
          } | {
            type: :tool_search_call,
            id: String,
            arguments: OpenAI::Internal::Type::Unknown,
            call_id: String | nil,
            execution: OpenAI::Responses::ResponseToolSearchCall::Execution,
            status: OpenAI::Responses::ResponseToolSearchCall::Status,
            created_by: String | nil
          } | {
            type: :tool_search_output,
            id: String,
            call_id: String | nil,
            execution: OpenAI::Responses::ResponseToolSearchOutputItem::Execution,
            status: OpenAI::Responses::ResponseToolSearchOutputItem::Status,
            tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool]),
            created_by: String | nil
          } | {
            type: :additional_tools,
            id: String,
            role: OpenAI::Responses::ResponseItem::AdditionalTools::Role,
            tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool])
          } | {
            type: :reasoning,
            id: String,
            summary: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Summary]),
            content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Content]) | nil,
            encrypted_content: String | nil,
            status: OpenAI::Responses::ResponseReasoningItem::Status | nil
          } | {type: :program, id: String, call_id: String, code: String, fingerprint: String} | {
            type: :program_output,
            id: String,
            call_id: String,
            result: String,
            status: OpenAI::Responses::ResponseItem::ProgramOutput::Status
          } | {type: :compaction, id: String, encrypted_content: String, created_by: String | nil} | {
            type: :image_generation_call,
            id: String,
            result: String | nil,
            status: OpenAI::Responses::ResponseItem::ImageGenerationCall::Status
          } | {
            type: :code_interpreter_call,
            id: String,
            code: String | nil,
            container_id: String,
            outputs: ^(OpenAI::Internal::Type::ArrayOf[
              union: OpenAI::Responses::ResponseCodeInterpreterToolCall::Output
            ]) | nil,
            status: OpenAI::Responses::ResponseCodeInterpreterToolCall::Status
          } | {
            type: :local_shell_call,
            id: String,
            action: OpenAI::Responses::ResponseItem::LocalShellCall::Action,
            call_id: String,
            status: OpenAI::Responses::ResponseItem::LocalShellCall::Status
          } | {
            type: :local_shell_call_output,
            id: String,
            output: String,
            status: OpenAI::Responses::ResponseItem::LocalShellCallOutput::Status | nil
          } | {
            type: :shell_call,
            id: String,
            action: OpenAI::Responses::ResponseFunctionShellToolCall::Action,
            call_id: String,
            environment: OpenAI::Responses::ResponseFunctionShellToolCall::Environment | nil,
            status: OpenAI::Responses::ResponseFunctionShellToolCall::Status,
            caller_: OpenAI::Responses::ResponseFunctionShellToolCall::Caller | nil,
            created_by: String | nil
          } | {
            type: :shell_call_output,
            id: String,
            call_id: String,
            max_output_length: Integer | nil,
            output: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFunctionShellToolCallOutput::Output]),
            status: OpenAI::Responses::ResponseFunctionShellToolCallOutput::Status,
            caller_: OpenAI::Responses::ResponseFunctionShellToolCallOutput::Caller | nil,
            created_by: String | nil
          } | {
            type: :apply_patch_call,
            id: String,
            call_id: String,
            operation: OpenAI::Responses::ResponseApplyPatchToolCall::Operation,
            status: OpenAI::Responses::ResponseApplyPatchToolCall::Status,
            caller_: OpenAI::Responses::ResponseApplyPatchToolCall::Caller | nil,
            created_by: String | nil
          } | {
            type: :apply_patch_call_output,
            id: String,
            call_id: String,
            status: OpenAI::Responses::ResponseApplyPatchToolCallOutput::Status,
            caller_: OpenAI::Responses::ResponseApplyPatchToolCallOutput::Caller | nil,
            created_by: String | nil,
            output: String | nil
          } | {
            type: :mcp_list_tools,
            id: String,
            server_label: String,
            tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseItem::McpListTools::Tool]),
            error: String | nil
          } | {type: :mcp_approval_request, id: String, arguments: String, name: String, server_label: String} | {
            type: :mcp_approval_response,
            id: String,
            approval_request_id: String,
            approve: OpenAI::Internal::Type::Boolean,
            reason: String | nil
          } | {
            type: :mcp_call,
            id: String,
            arguments: String,
            name: String,
            server_label: String,
            approval_request_id: String | nil,
            error: OpenAI::Responses::McpToolCallError | nil,
            output: String | nil,
            status: OpenAI::Responses::ResponseItem::McpCall::Status | nil
          }
      )
        nil
      end
    end
  end
end
