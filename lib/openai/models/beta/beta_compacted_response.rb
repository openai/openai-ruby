# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Responses#compact
      class BetaCompactedResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique identifier for the compacted response.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) when the compacted conversation was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute object
        #   The object type. Always `response.compaction`.
        #
        #   @return [Symbol, :"response.compaction"]
        required :object, const: :"response.compaction"

        # @!attribute output
        #   The compacted list of output items. This is a list of all user messages,
        #   followed by a single compaction item.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
        required :output, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem] }

        # @!attribute usage
        #   Token accounting for the compaction pass, including cached, reasoning, and total
        #   tokens.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseUsage]
        required :usage, -> { OpenAI::Beta::BetaResponseUsage }

        # @!method initialize(id:, created_at:, output:, usage:, object: :"response.compaction")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaCompactedResponse} for more details.
        #
        #   @param id [String] The unique identifier for the compacted response.
        #
        #   @param created_at [Integer] Unix timestamp (in seconds) when the compacted conversation was created.
        #
        #   @param output [Array<OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>] The compacted list of output items. This is a list of all user messages, followe
        #
        #   @param usage [OpenAI::Models::Beta::BetaResponseUsage] Token accounting for the compaction pass, including cached, reasoning, and total
        #
        #   @param object [Symbol, :"response.compaction"] The object type. Always `response.compaction`.
      end
    end

    BetaCompactedResponse = Beta::BetaCompactedResponse
  end
end
