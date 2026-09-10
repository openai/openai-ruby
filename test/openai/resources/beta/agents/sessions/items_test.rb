# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::ItemsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.beta.agents.sessions.items.list("session_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::AgentSessionItem
    end

    assert_pattern do
      case row
      in (
        OpenAI::Beta::AgentSessionMessage | OpenAI::Beta::AgentReasoningItem | OpenAI::Beta::AgentFunctionCallItem | OpenAI::Beta::AgentSessionItem::FunctionCallOutput | OpenAI::Beta::AgentSessionItem::AgentMessage | OpenAI::Beta::AgentMcpCallItem | OpenAI::Beta::AgentWebSearchCallItem | OpenAI::Beta::AgentCommandExecutionItem | OpenAI::Beta::AgentCreateSubagentCallItem | OpenAI::Beta::AgentSendSubagentInputCallItem | OpenAI::Beta::AgentResumeSubagentCallItem | OpenAI::Beta::AgentWaitForSubagentsCallItem | OpenAI::Beta::AgentInterruptSubagentCallItem | OpenAI::Beta::AgentCloseSubagentCallItem
      )
        nil
      end
    end

    assert_pattern do
      case row
      in (
        {
            type: :message,
            id: String | nil,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSessionMessageContent]),
            phase: OpenAI::Beta::AgentSessionMessage::Phase | nil,
            role: OpenAI::Beta::AgentSessionMessage::Role,
            status: OpenAI::Beta::AgentOutputItemStatus,
            turn_id: String
          } | {
            type: :reasoning,
            id: String,
            status: OpenAI::Beta::AgentOutputItemStatus | nil,
            summary: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::SummaryText]),
            turn_id: String
          } | {
            type: :function_call,
            id: String,
            arguments: OpenAI::Internal::Type::Unknown,
            call_id: String,
            name: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :function_call_output,
            id: String,
            call_id: String,
            error: String | nil,
            output: OpenAI::Beta::AgentFunctionCallOutput | nil,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :agent_message,
            id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]),
            recipient_agent_id: String,
            sender_agent_id: String,
            turn_id: String
          } | {
            type: :mcp_call,
            id: String,
            arguments: OpenAI::Internal::Type::Unknown,
            error: OpenAI::Internal::Type::Unknown,
            name: String,
            output: OpenAI::Internal::Type::Unknown,
            server_label: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :web_search_call,
            id: String,
            action: OpenAI::Beta::WebSearchAction | nil,
            status: OpenAI::Beta::AgentOutputItemStatus,
            turn_id: String
          } | {
            type: :command_execution,
            id: String,
            command: String,
            cwd: String | nil,
            duration_ms: Integer | nil,
            exit_code: Integer | nil,
            output: String | nil,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :create_subagent_call,
            id: String,
            agent_id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]),
            model: String | nil,
            reasoning_effort: String | nil,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :send_subagent_input_call,
            id: String,
            content: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]),
            recipient_agent_id: String,
            sender_agent_id: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :resume_subagent_call,
            id: String,
            recipient_agent_id: String,
            sender_agent_id: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :wait_for_subagents_call,
            id: String,
            recipient_agent_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
            sender_agent_id: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :interrupt_subagent_call,
            id: String,
            recipient_agent_id: String,
            sender_agent_id: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          } | {
            type: :close_subagent_call,
            id: String,
            recipient_agent_id: String,
            sender_agent_id: String,
            status: OpenAI::Beta::AgentFunctionCallStatus,
            turn_id: String
          }
      )
        nil
      end
    end
  end
end
