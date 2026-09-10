# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An output item produced by an agent.
      module AgentOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # An assistant message produced by the agent.
        variant :message, -> { OpenAI::Beta::AgentSessionAssistantMessage }

        # A reasoning item produced by the agent.
        variant :reasoning, -> { OpenAI::Beta::AgentReasoningItem }

        # A function call produced by the agent.
        variant :function_call, -> { OpenAI::Beta::AgentFunctionCallItem }

        # A call to a tool on an MCP server.
        variant :mcp_call, -> { OpenAI::Beta::AgentMcpCallItem }

        # A web search call produced by the agent.
        variant :web_search_call, -> { OpenAI::Beta::AgentWebSearchCallItem }

        # A command execution produced by the agent.
        variant :command_execution, -> { OpenAI::Beta::AgentCommandExecutionItem }

        # A request to spawn a subagent.
        variant :create_subagent_call, -> { OpenAI::Beta::AgentCreateSubagentCallItem }

        # A request to send input to another agent.
        variant :send_subagent_input_call, -> { OpenAI::Beta::AgentSendSubagentInputCallItem }

        # A request to resume a subagent.
        variant :resume_subagent_call, -> { OpenAI::Beta::AgentResumeSubagentCallItem }

        # A request to wait for one or more subagents.
        variant :wait_for_subagents_call, -> { OpenAI::Beta::AgentWaitForSubagentsCallItem }

        # A request to interrupt a subagent's current turn. The subagent remains available.
        variant :interrupt_subagent_call, -> { OpenAI::Beta::AgentInterruptSubagentCallItem }

        # A request to close a subagent.
        variant :close_subagent_call, -> { OpenAI::Beta::AgentCloseSubagentCallItem }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionAssistantMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem)]
      end
    end
  end
end
