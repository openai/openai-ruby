# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Responses::InputItemsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.beta.responses.input_items.list("response_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::BetaResponseItem
    end

    assert_pattern do
      case row
      in OpenAI::Beta::BetaResponseInputMessageItem
      in OpenAI::Beta::BetaResponseOutputMessage
      in OpenAI::Beta::BetaResponseFileSearchToolCall
      in OpenAI::Beta::BetaResponseComputerToolCall
      in OpenAI::Beta::BetaResponseComputerToolCallOutputItem
      in OpenAI::Beta::BetaResponseFunctionWebSearch
      in OpenAI::Beta::BetaResponseFunctionToolCallItem
      in OpenAI::Beta::BetaResponseFunctionToolCallOutputItem
      in OpenAI::Beta::BetaResponseItem::AgentMessage
      in OpenAI::Beta::BetaResponseItem::MultiAgentCall
      in OpenAI::Beta::BetaResponseItem::MultiAgentCallOutput
      in OpenAI::Beta::BetaResponseToolSearchCall
      in OpenAI::Beta::BetaResponseToolSearchOutputItem
      in OpenAI::Beta::BetaResponseItem::AdditionalTools
      in OpenAI::Beta::BetaResponseReasoningItem
      in OpenAI::Beta::BetaResponseItem::Program
      in OpenAI::Beta::BetaResponseItem::ProgramOutput
      in OpenAI::Beta::BetaResponseCompactionItem
      in OpenAI::Beta::BetaResponseItem::ImageGenerationCall
      in OpenAI::Beta::BetaResponseCodeInterpreterToolCall
      in OpenAI::Beta::BetaResponseItem::LocalShellCall
      in OpenAI::Beta::BetaResponseItem::LocalShellCallOutput
      in OpenAI::Beta::BetaResponseFunctionShellToolCall
      in OpenAI::Beta::BetaResponseFunctionShellToolCallOutput
      in OpenAI::Beta::BetaResponseApplyPatchToolCall
      in OpenAI::Beta::BetaResponseApplyPatchToolCallOutput
      in OpenAI::Beta::BetaResponseItem::McpListTools
      in OpenAI::Beta::BetaResponseItem::McpApprovalRequest
      in OpenAI::Beta::BetaResponseItem::McpApprovalResponse
      in OpenAI::Beta::BetaResponseItem::McpCall
      in OpenAI::Beta::BetaResponseCustomToolCallItem
      in OpenAI::Beta::BetaResponseCustomToolCallOutputItem
      end
    end

    assert_pattern do
      case row
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseInputContent]),
        role: OpenAI::Beta::BetaResponseInputMessageItem::Role,
        agent: OpenAI::Beta::BetaResponseInputMessageItem::Agent | nil,
        status: OpenAI::Beta::BetaResponseInputMessageItem::Status | nil
      }
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputMessage::Content]),
        role: Symbol,
        status: OpenAI::Beta::BetaResponseOutputMessage::Status,
        agent: OpenAI::Beta::BetaResponseOutputMessage::Agent | nil,
        phase: OpenAI::Beta::BetaResponseOutputMessage::Phase | nil
      }
      in {
        type: :file_search_call,
        id: String,
        queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
        status: OpenAI::Beta::BetaResponseFileSearchToolCall::Status,
        agent: OpenAI::Beta::BetaResponseFileSearchToolCall::Agent | nil,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseFileSearchToolCall::Result]) | nil
      }
      in {
        type: :computer_call,
        id: String,
        call_id: String,
        pending_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck]),
        status: OpenAI::Beta::BetaResponseComputerToolCall::Status,
        action: OpenAI::Beta::BetaComputerAction | nil,
        actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaComputerAction]) | nil,
        agent: OpenAI::Beta::BetaResponseComputerToolCall::Agent | nil
      }
      in {
        type: :computer_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot,
        status: OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status,
        acknowledged_safety_checks: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck]) | nil,
        agent: OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent | nil,
        created_by: String | nil
      }
      in {
        type: :web_search_call,
        id: String,
        action: OpenAI::Beta::BetaResponseFunctionWebSearch::Action,
        status: OpenAI::Beta::BetaResponseFunctionWebSearch::Status,
        agent: OpenAI::Beta::BetaResponseFunctionWebSearch::Agent | nil
      }
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::Output,
        status: OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::Status,
        agent: OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::Agent | nil,
        caller_: OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::Caller | nil,
        created_by: String | nil
      }
      in {
        type: :agent_message,
        id: String,
        author: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseItem::AgentMessage::Content]),
        recipient: String,
        agent: OpenAI::Beta::BetaResponseItem::AgentMessage::Agent | nil
      }
      in {
        type: :multi_agent_call,
        id: String,
        action: OpenAI::Beta::BetaResponseItem::MultiAgentCall::Action,
        arguments: String,
        call_id: String,
        agent: OpenAI::Beta::BetaResponseItem::MultiAgentCall::Agent | nil
      }
      in {
        type: :multi_agent_call_output,
        id: String,
        action: OpenAI::Beta::BetaResponseItem::MultiAgentCallOutput::Action,
        call_id: String,
        output: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseOutputText]),
        agent: OpenAI::Beta::BetaResponseItem::MultiAgentCallOutput::Agent | nil
      }
      in {
        type: :tool_search_call,
        id: String,
        arguments: OpenAI::Internal::Type::Unknown,
        call_id: String | nil,
        execution: OpenAI::Beta::BetaResponseToolSearchCall::Execution,
        status: OpenAI::Beta::BetaResponseToolSearchCall::Status,
        agent: OpenAI::Beta::BetaResponseToolSearchCall::Agent | nil,
        created_by: String | nil
      }
      in {
        type: :tool_search_output,
        id: String,
        call_id: String | nil,
        execution: OpenAI::Beta::BetaResponseToolSearchOutputItem::Execution,
        status: OpenAI::Beta::BetaResponseToolSearchOutputItem::Status,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool]),
        agent: OpenAI::Beta::BetaResponseToolSearchOutputItem::Agent | nil,
        created_by: String | nil
      }
      in {
        type: :additional_tools,
        id: String,
        role: OpenAI::Beta::BetaResponseItem::AdditionalTools::Role,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool]),
        agent: OpenAI::Beta::BetaResponseItem::AdditionalTools::Agent | nil
      }
      in {
        type: :reasoning,
        id: String,
        summary: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseReasoningItem::Summary]),
        agent: OpenAI::Beta::BetaResponseReasoningItem::Agent | nil,
        content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseReasoningItem::Content]) | nil,
        encrypted_content: String | nil,
        status: OpenAI::Beta::BetaResponseReasoningItem::Status | nil
      }
      in {
        type: :program,
        id: String,
        call_id: String,
        code: String,
        fingerprint: String,
        agent: OpenAI::Beta::BetaResponseItem::Program::Agent | nil
      }
      in {
        type: :program_output,
        id: String,
        call_id: String,
        result: String,
        status: OpenAI::Beta::BetaResponseItem::ProgramOutput::Status,
        agent: OpenAI::Beta::BetaResponseItem::ProgramOutput::Agent | nil
      }
      in {
        type: :compaction,
        id: String,
        encrypted_content: String,
        agent: OpenAI::Beta::BetaResponseCompactionItem::Agent | nil,
        created_by: String | nil
      }
      in {
        type: :image_generation_call,
        id: String,
        result: String | nil,
        status: OpenAI::Beta::BetaResponseItem::ImageGenerationCall::Status,
        agent: OpenAI::Beta::BetaResponseItem::ImageGenerationCall::Agent | nil
      }
      in {
        type: :code_interpreter_call,
        id: String,
        code: String | nil,
        container_id: String,
        outputs: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseCodeInterpreterToolCall::Output]) | nil,
        status: OpenAI::Beta::BetaResponseCodeInterpreterToolCall::Status,
        agent: OpenAI::Beta::BetaResponseCodeInterpreterToolCall::Agent | nil
      }
      in {
        type: :local_shell_call,
        id: String,
        action: OpenAI::Beta::BetaResponseItem::LocalShellCall::Action,
        call_id: String,
        status: OpenAI::Beta::BetaResponseItem::LocalShellCall::Status,
        agent: OpenAI::Beta::BetaResponseItem::LocalShellCall::Agent | nil
      }
      in {
        type: :local_shell_call_output,
        id: String,
        output: String,
        agent: OpenAI::Beta::BetaResponseItem::LocalShellCallOutput::Agent | nil,
        status: OpenAI::Beta::BetaResponseItem::LocalShellCallOutput::Status | nil
      }
      in {
        type: :shell_call,
        id: String,
        action: OpenAI::Beta::BetaResponseFunctionShellToolCall::Action,
        call_id: String,
        environment: OpenAI::Beta::BetaResponseFunctionShellToolCall::Environment | nil,
        status: OpenAI::Beta::BetaResponseFunctionShellToolCall::Status,
        agent: OpenAI::Beta::BetaResponseFunctionShellToolCall::Agent | nil,
        caller_: OpenAI::Beta::BetaResponseFunctionShellToolCall::Caller | nil,
        created_by: String | nil
      }
      in {
        type: :shell_call_output,
        id: String,
        call_id: String,
        max_output_length: Integer | nil,
        output: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::Output]),
        status: OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::Status,
        agent: OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::Agent | nil,
        caller_: OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::Caller | nil,
        created_by: String | nil
      }
      in {
        type: :apply_patch_call,
        id: String,
        call_id: String,
        operation: OpenAI::Beta::BetaResponseApplyPatchToolCall::Operation,
        status: OpenAI::Beta::BetaResponseApplyPatchToolCall::Status,
        agent: OpenAI::Beta::BetaResponseApplyPatchToolCall::Agent | nil,
        caller_: OpenAI::Beta::BetaResponseApplyPatchToolCall::Caller | nil,
        created_by: String | nil
      }
      in {
        type: :apply_patch_call_output,
        id: String,
        call_id: String,
        status: OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::Status,
        agent: OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::Agent | nil,
        caller_: OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::Caller | nil,
        created_by: String | nil,
        output: String | nil
      }
      in {
        type: :mcp_list_tools,
        id: String,
        server_label: String,
        tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseItem::McpListTools::Tool]),
        agent: OpenAI::Beta::BetaResponseItem::McpListTools::Agent | nil,
        error: String | nil
      }
      in {
        type: :mcp_approval_request,
        id: String,
        arguments: String,
        name: String,
        server_label: String,
        agent: OpenAI::Beta::BetaResponseItem::McpApprovalRequest::Agent | nil
      }
      in {
        type: :mcp_approval_response,
        id: String,
        approval_request_id: String,
        approve: OpenAI::Internal::Type::Boolean,
        agent: OpenAI::Beta::BetaResponseItem::McpApprovalResponse::Agent | nil,
        reason: String | nil
      }
      in {
        type: :mcp_call,
        id: String,
        arguments: String,
        name: String,
        server_label: String,
        agent: OpenAI::Beta::BetaResponseItem::McpCall::Agent | nil,
        approval_request_id: String | nil,
        error: String | nil,
        output: String | nil,
        status: OpenAI::Beta::BetaResponseItem::McpCall::Status | nil
      }
      end
    end
  end
end
