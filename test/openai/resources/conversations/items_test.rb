# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Conversations::ItemsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.conversations.items.create(
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
      in OpenAI::Conversations::Message
      in OpenAI::Responses::ResponseFunctionToolCallItem
      in OpenAI::Responses::ResponseFunctionToolCallOutputItem
      in OpenAI::Responses::ResponseFileSearchToolCall
      in OpenAI::Responses::ResponseFunctionWebSearch
      in OpenAI::Conversations::ConversationItem::ImageGenerationCall
      in OpenAI::Responses::ResponseComputerToolCall
      in OpenAI::Responses::ResponseComputerToolCallOutputItem
      in OpenAI::Responses::ResponseReasoningItem
      in OpenAI::Responses::ResponseCodeInterpreterToolCall
      in OpenAI::Conversations::ConversationItem::LocalShellCall
      in OpenAI::Conversations::ConversationItem::LocalShellCallOutput
      in OpenAI::Responses::ResponseFunctionShellToolCall
      in OpenAI::Responses::ResponseFunctionShellToolCallOutput
      in OpenAI::Responses::ResponseApplyPatchToolCall
      in OpenAI::Responses::ResponseApplyPatchToolCallOutput
      in OpenAI::Conversations::ConversationItem::McpListTools
      in OpenAI::Conversations::ConversationItem::McpApprovalRequest
      in OpenAI::Conversations::ConversationItem::McpApprovalResponse
      in OpenAI::Conversations::ConversationItem::McpCall
      in OpenAI::Responses::ResponseCustomToolCall
      in OpenAI::Responses::ResponseCustomToolCallOutput
      end
    end

    assert_pattern do
      case response
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::Message::Content]),
        role: OpenAI::Conversations::Message::Role,
        status: OpenAI::Conversations::Message::Status
      }
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Output,
        status: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Status | nil
      }
      in {
        type: :file_search_call,
        id: String,
        queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
        status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
      }
      in {
        type: :web_search_call,
        id: String,
        action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
        status: OpenAI::Responses::ResponseFunctionWebSearch::Status
      }
      in {
        type: :image_generation_call,
        id: String,
        result: String | nil,
        status: OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status
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
        type: :reasoning,
        id: String,
        summary: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Summary]),
        content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Content]) | nil,
        encrypted_content: String | nil,
        status: OpenAI::Responses::ResponseReasoningItem::Status | nil
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
        action: OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
        call_id: String,
        status: OpenAI::Conversations::ConversationItem::LocalShellCall::Status
      }
      in {
        type: :local_shell_call_output,
        id: String,
        output: String,
        status: OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status | nil
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
        status: OpenAI::Responses::ResponseFunctionShellToolCallOutput::Status,
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
        tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::ConversationItem::McpListTools::Tool]),
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
        status: OpenAI::Conversations::ConversationItem::McpCall::Status | nil
      }
      in {type: :custom_tool_call, call_id: String, input: String, name: String, id: String | nil}
      in {
        type: :custom_tool_call_output,
        call_id: String,
        output: OpenAI::Responses::ResponseCustomToolCallOutput::Output,
        id: String | nil
      }
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
      in OpenAI::Conversations::Message
      in OpenAI::Responses::ResponseFunctionToolCallItem
      in OpenAI::Responses::ResponseFunctionToolCallOutputItem
      in OpenAI::Responses::ResponseFileSearchToolCall
      in OpenAI::Responses::ResponseFunctionWebSearch
      in OpenAI::Conversations::ConversationItem::ImageGenerationCall
      in OpenAI::Responses::ResponseComputerToolCall
      in OpenAI::Responses::ResponseComputerToolCallOutputItem
      in OpenAI::Responses::ResponseReasoningItem
      in OpenAI::Responses::ResponseCodeInterpreterToolCall
      in OpenAI::Conversations::ConversationItem::LocalShellCall
      in OpenAI::Conversations::ConversationItem::LocalShellCallOutput
      in OpenAI::Responses::ResponseFunctionShellToolCall
      in OpenAI::Responses::ResponseFunctionShellToolCallOutput
      in OpenAI::Responses::ResponseApplyPatchToolCall
      in OpenAI::Responses::ResponseApplyPatchToolCallOutput
      in OpenAI::Conversations::ConversationItem::McpListTools
      in OpenAI::Conversations::ConversationItem::McpApprovalRequest
      in OpenAI::Conversations::ConversationItem::McpApprovalResponse
      in OpenAI::Conversations::ConversationItem::McpCall
      in OpenAI::Responses::ResponseCustomToolCall
      in OpenAI::Responses::ResponseCustomToolCallOutput
      end
    end

    assert_pattern do
      case row
      in {
        type: :message,
        id: String,
        content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::Message::Content]),
        role: OpenAI::Conversations::Message::Role,
        status: OpenAI::Conversations::Message::Status
      }
      in {
        type: :function_call_output,
        id: String,
        call_id: String,
        output: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Output,
        status: OpenAI::Responses::ResponseFunctionToolCallOutputItem::Status | nil
      }
      in {
        type: :file_search_call,
        id: String,
        queries: ^(OpenAI::Internal::Type::ArrayOf[String]),
        status: OpenAI::Responses::ResponseFileSearchToolCall::Status,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]) | nil
      }
      in {
        type: :web_search_call,
        id: String,
        action: OpenAI::Responses::ResponseFunctionWebSearch::Action,
        status: OpenAI::Responses::ResponseFunctionWebSearch::Status
      }
      in {
        type: :image_generation_call,
        id: String,
        result: String | nil,
        status: OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status
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
        type: :reasoning,
        id: String,
        summary: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Summary]),
        content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Content]) | nil,
        encrypted_content: String | nil,
        status: OpenAI::Responses::ResponseReasoningItem::Status | nil
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
        action: OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
        call_id: String,
        status: OpenAI::Conversations::ConversationItem::LocalShellCall::Status
      }
      in {
        type: :local_shell_call_output,
        id: String,
        output: String,
        status: OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status | nil
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
        status: OpenAI::Responses::ResponseFunctionShellToolCallOutput::Status,
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
        tools: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::ConversationItem::McpListTools::Tool]),
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
        status: OpenAI::Conversations::ConversationItem::McpCall::Status | nil
      }
      in {type: :custom_tool_call, call_id: String, input: String, name: String, id: String | nil}
      in {
        type: :custom_tool_call_output,
        call_id: String,
        output: OpenAI::Responses::ResponseCustomToolCallOutput::Output,
        id: String | nil
      }
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
