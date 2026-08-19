# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Responses
        class BetaResponseItemList < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   A list of items used to generate this response.
          #
          #   @return [Array<OpenAI::Models::Beta::BetaResponseInputMessageItem, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseItem::AgentMessage, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseItem::Program, OpenAI::Models::Beta::BetaResponseItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseItem::McpListTools, OpenAI::Models::Beta::BetaResponseItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallItem, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
          required :data, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseItem] }

          # @!attribute first_id
          #   The ID of the first item in the list.
          #
          #   @return [String]
          required :first_id, String

          # @!attribute has_more
          #   Whether there are more items available.
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute last_id
          #   The ID of the last item in the list.
          #
          #   @return [String]
          required :last_id, String

          # @!attribute object
          #   The type of object returned, must be `list`.
          #
          #   @return [Symbol, :list]
          required :object, const: :list

          # @!method initialize(data:, first_id:, has_more:, last_id:, object: :list)
          #   A list of Response items.
          #
          #   @param data [Array<OpenAI::Models::Beta::BetaResponseInputMessageItem, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseItem::AgentMessage, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseItem::Program, OpenAI::Models::Beta::BetaResponseItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseItem::McpListTools, OpenAI::Models::Beta::BetaResponseItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallItem, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>] A list of items used to generate this response.
          #
          #   @param first_id [String] The ID of the first item in the list.
          #
          #   @param has_more [Boolean] Whether there are more items available.
          #
          #   @param last_id [String] The ID of the last item in the list.
          #
          #   @param object [Symbol, :list] The type of object returned, must be `list`.
        end
      end
    end
  end
end
