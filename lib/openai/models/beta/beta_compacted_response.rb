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
        #   @return [Array<OpenAI::Models::Beta::BetaResponseInputMessageItem, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseItem::AgentMessage, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseItem::Program, OpenAI::Models::Beta::BetaResponseItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseItem::McpListTools, OpenAI::Models::Beta::BetaResponseItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallItem, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
        required :output, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseItem] }

        # @!attribute usage
        #   Token accounting for the compaction pass, including cached, reasoning, and total
        #   tokens.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseUsage]
        required :usage, -> { OpenAI::Beta::BetaResponseUsage }

        # @!attribute image
        #
        #   @return [OpenAI::Models::Beta::BetaCompactedResponse::Image, nil]
        optional :image, -> { OpenAI::Beta::BetaCompactedResponse::Image }

        # @!method initialize(id:, created_at:, output:, usage:, image: nil, object: :"response.compaction")
        #   @param id [String]
        #     The unique identifier for the compacted response.
        #
        #   @param created_at [Integer]
        #     Unix timestamp (in seconds) when the compacted conversation was created.
        #
        #   @param output [Array<OpenAI::Models::Beta::BetaResponseInputMessageItem, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseItem::AgentMessage, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseItem::Program, OpenAI::Models::Beta::BetaResponseItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseItem::McpListTools, OpenAI::Models::Beta::BetaResponseItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallItem, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
        #     The compacted list of output items. This is a list of all user messages,
        #     followed by a single compaction item.
        #
        #   @param usage [OpenAI::Models::Beta::BetaResponseUsage]
        #     Token accounting for the compaction pass, including cached, reasoning, and total
        #     tokens.
        #
        #   @param image [OpenAI::Models::Beta::BetaCompactedResponse::Image]
        #
        #   @param object [Symbol, :"response.compaction"]
        #     The object type. Always `response.compaction`.

        # @see OpenAI::Models::Beta::BetaCompactedResponse#image
        class Image < OpenAI::Internal::Type::BaseModel
          # @!attribute context_compression
          #   Effective image context optimization policy.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaCompactedResponse::Image::ContextCompression]
          required :context_compression, enum: -> { OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression }

          # @!method initialize(context_compression:)
          #   @param context_compression [Symbol, OpenAI::Models::Beta::BetaCompactedResponse::Image::ContextCompression]
          #     Effective image context optimization policy.

          # Effective image context optimization policy.
          #
          # @see OpenAI::Models::Beta::BetaCompactedResponse::Image#context_compression
          module ContextCompression
            extend OpenAI::Internal::Type::Enum

            ENABLED = :enabled
            DISABLED = :disabled

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    BetaCompactedResponse = Beta::BetaCompactedResponse
  end
end
