# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Conversations::ItemsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.conversations.items.create(
      "conv_123",
      items: [{content: "string", role: :user, type: :message}]
    )

    assert_pattern do
      response => OpenAI::Conversations::ConversationItemList
    end

    assert_pattern do
      response => {
          data: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::ConversationItem]),
          first_id: String,
          has_more: OpenAI::Internal::Type::Boolean,
          last_id: String,
          object: Symbol
        }
    end
  end

  def test_retrieve_required_params
    response = @openai.conversations.items.retrieve("msg_abc", conversation_id: "conv_123")

    assert_pattern do
      response => OpenAI::Conversations::ConversationItem
    end

    assert_pattern do
      case response
      in (
        OpenAI::Conversations::Message | OpenAI::Responses::ResponseFunctionToolCallItem | OpenAI::Responses::ResponseFunctionToolCallOutputItem | OpenAI::Responses::ResponseFileSearchToolCall | OpenAI::Responses::ResponseFunctionWebSearch | OpenAI::Conversations::ConversationItem::ImageGenerationCall | OpenAI::Responses::ResponseComputerToolCall | OpenAI::Responses::ResponseComputerToolCallOutputItem | OpenAI::Responses::ResponseToolSearchCall | OpenAI::Responses::ResponseToolSearchOutputItem | OpenAI::Conversations::ConversationItem::AdditionalTools | OpenAI::Responses::ResponseConfigurationUpdateItem | OpenAI::Responses::ResponseReasoningItem | OpenAI::Conversations::ConversationItem::Program | OpenAI::Conversations::ConversationItem::ProgramOutput | OpenAI::Responses::ResponseCompactionItem | OpenAI::Responses::ResponseCodeInterpreterToolCall | OpenAI::Conversations::ConversationItem::LocalShellCall | OpenAI::Conversations::ConversationItem::LocalShellCallOutput | OpenAI::Responses::ResponseFunctionShellToolCall | OpenAI::Responses::ResponseFunctionShellToolCallOutput | OpenAI::Responses::ResponseApplyPatchToolCall | OpenAI::Responses::ResponseApplyPatchToolCallOutput | OpenAI::Conversations::ConversationItem::McpListTools | OpenAI::Conversations::ConversationItem::McpApprovalRequest | OpenAI::Conversations::ConversationItem::McpApprovalResponse | OpenAI::Conversations::ConversationItem::McpCall | OpenAI::Responses::ResponseCustomToolCall | OpenAI::Responses::ResponseCustomToolCallOutput
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :message,
            id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::Message::Content]),
            role: OpenAI::Conversations::Message::Role,
            status: OpenAI::Conversations::Message::Status,
            phase: OpenAI::Conversations::Message::Phase | nil
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
            type: :file_search_call,
            id: String,
            queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
            status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
            results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
          } | {
            type: :web_search_call,
            id: String,
            action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
            status: OpenAI::Responses::ResponseFunctionWebSearch::Status
          } | {
            type: :image_generation_call,
            id: String,
            result: String | nil,
            status: OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status
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
            role: OpenAI::Conversations::ConversationItem::AdditionalTools::Role,
            tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool])
          } | {
            type: :configuration_update,
            id: String,
            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning | nil
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
            status: OpenAI::Conversations::ConversationItem::ProgramOutput::Status
          } | {type: :compaction, id: String, encrypted_content: String, created_by: String | nil} | {
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
            action: OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
            call_id: String,
            status: OpenAI::Conversations::ConversationItem::LocalShellCall::Status
          } | {
            type: :local_shell_call_output,
            id: String,
            output: String,
            status: OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status | nil
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
            tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::ConversationItem::McpListTools::Tool]),
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
            status: OpenAI::Conversations::ConversationItem::McpCall::Status | nil
          } | {
            type: :custom_tool_call,
            call_id: String,
            input: String,
            name: String,
            id: String | nil,
            async: OpenAI::Internal::Type::Boolean | nil,
            caller_: OpenAI::Responses::ResponseCustomToolCall::Caller | nil,
            namespace: String | nil
          } | {
            type: :custom_tool_call_output,
            call_id: String,
            output: OpenAI::Responses::ResponseCustomToolCallOutput::Output,
            id: String | nil,
            caller_: OpenAI::Responses::ResponseCustomToolCallOutput::Caller | nil
          }
      )
        nil
      end
    end
  end

  def test_list
    response = @openai.conversations.items.list("conv_123")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Conversations::ConversationItem
    end

    assert_pattern do
      case row
      in (
        OpenAI::Conversations::Message | OpenAI::Responses::ResponseFunctionToolCallItem | OpenAI::Responses::ResponseFunctionToolCallOutputItem | OpenAI::Responses::ResponseFileSearchToolCall | OpenAI::Responses::ResponseFunctionWebSearch | OpenAI::Conversations::ConversationItem::ImageGenerationCall | OpenAI::Responses::ResponseComputerToolCall | OpenAI::Responses::ResponseComputerToolCallOutputItem | OpenAI::Responses::ResponseToolSearchCall | OpenAI::Responses::ResponseToolSearchOutputItem | OpenAI::Conversations::ConversationItem::AdditionalTools | OpenAI::Responses::ResponseConfigurationUpdateItem | OpenAI::Responses::ResponseReasoningItem | OpenAI::Conversations::ConversationItem::Program | OpenAI::Conversations::ConversationItem::ProgramOutput | OpenAI::Responses::ResponseCompactionItem | OpenAI::Responses::ResponseCodeInterpreterToolCall | OpenAI::Conversations::ConversationItem::LocalShellCall | OpenAI::Conversations::ConversationItem::LocalShellCallOutput | OpenAI::Responses::ResponseFunctionShellToolCall | OpenAI::Responses::ResponseFunctionShellToolCallOutput | OpenAI::Responses::ResponseApplyPatchToolCall | OpenAI::Responses::ResponseApplyPatchToolCallOutput | OpenAI::Conversations::ConversationItem::McpListTools | OpenAI::Conversations::ConversationItem::McpApprovalRequest | OpenAI::Conversations::ConversationItem::McpApprovalResponse | OpenAI::Conversations::ConversationItem::McpCall | OpenAI::Responses::ResponseCustomToolCall | OpenAI::Responses::ResponseCustomToolCallOutput
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
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::Message::Content]),
            role: OpenAI::Conversations::Message::Role,
            status: OpenAI::Conversations::Message::Status,
            phase: OpenAI::Conversations::Message::Phase | nil
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
            type: :file_search_call,
            id: String,
            queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
            status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
            results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
          } | {
            type: :web_search_call,
            id: String,
            action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
            status: OpenAI::Responses::ResponseFunctionWebSearch::Status
          } | {
            type: :image_generation_call,
            id: String,
            result: String | nil,
            status: OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status
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
            role: OpenAI::Conversations::ConversationItem::AdditionalTools::Role,
            tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool])
          } | {
            type: :configuration_update,
            id: String,
            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning | nil
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
            status: OpenAI::Conversations::ConversationItem::ProgramOutput::Status
          } | {type: :compaction, id: String, encrypted_content: String, created_by: String | nil} | {
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
            action: OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
            call_id: String,
            status: OpenAI::Conversations::ConversationItem::LocalShellCall::Status
          } | {
            type: :local_shell_call_output,
            id: String,
            output: String,
            status: OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status | nil
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
            tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::ConversationItem::McpListTools::Tool]),
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
            status: OpenAI::Conversations::ConversationItem::McpCall::Status | nil
          } | {
            type: :custom_tool_call,
            call_id: String,
            input: String,
            name: String,
            id: String | nil,
            async: OpenAI::Internal::Type::Boolean | nil,
            caller_: OpenAI::Responses::ResponseCustomToolCall::Caller | nil,
            namespace: String | nil
          } | {
            type: :custom_tool_call_output,
            call_id: String,
            output: OpenAI::Responses::ResponseCustomToolCallOutput::Output,
            id: String | nil,
            caller_: OpenAI::Responses::ResponseCustomToolCallOutput::Caller | nil
          }
      )
        nil
      end
    end
  end

  def test_delete_required_params
    response = @openai.conversations.items.delete("msg_abc", conversation_id: "conv_123")

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
end
