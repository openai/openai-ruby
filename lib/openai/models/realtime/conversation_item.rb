# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # A single item within a Realtime conversation.
      module ConversationItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A system message item in a Realtime conversation.
        variant :message, -> { OpenAI::Realtime::RealtimeConversationItemSystemMessage }

        # A user message item in a Realtime conversation.
        variant :message, -> { OpenAI::Realtime::RealtimeConversationItemUserMessage }

        # An assistant message item in a Realtime conversation.
        variant :message, -> { OpenAI::Realtime::RealtimeConversationItemAssistantMessage }

        # A function call item in a Realtime conversation.
        variant :function_call, -> { OpenAI::Realtime::RealtimeConversationItemFunctionCall }

        # A function call output item in a Realtime conversation.
        variant :function_call_output, -> { OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput }

        # A Realtime item responding to an MCP approval request.
        variant :mcp_approval_response, -> { OpenAI::Realtime::RealtimeMcpApprovalResponse }

        # A Realtime item listing tools available on an MCP server.
        variant :mcp_list_tools, -> { OpenAI::Realtime::RealtimeMcpListTools }

        # A Realtime item representing an invocation of a tool on an MCP server.
        variant :mcp_tool_call, -> { OpenAI::Realtime::RealtimeMcpToolCall }

        # A Realtime item requesting human approval of a tool invocation.
        variant :mcp_approval_request, -> { OpenAI::Realtime::RealtimeMcpApprovalRequest }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest)]
      end
    end
  end
end
