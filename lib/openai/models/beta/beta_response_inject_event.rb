# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInjectEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #   Input items to inject into the active response.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>]
        required :input, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseInputItem] }

        # @!attribute response_id
        #   The ID of the active response that should receive the input.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event discriminator. Always `response.inject`.
        #
        #   @return [Symbol, :"response.inject"]
        required :type, const: :"response.inject"

        # @!method initialize(input:, response_id:, type: :"response.inject")
        #   Injects input items into an active response over a WebSocket connection. The
        #   items are validated and committed atomically. Currently, the server accepts
        #   client-owned tool outputs that resume a waiting agent.
        #
        #   @param input [Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>] Input items to inject into the active response.
        #
        #   @param response_id [String] The ID of the active response that should receive the input.
        #
        #   @param type [Symbol, :"response.inject"] The event discriminator. Always `response.inject`.
      end
    end

    BetaResponseInjectEvent = Beta::BetaResponseInjectEvent
  end
end
