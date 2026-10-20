# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#compact
      class CompactedResponse < OpenAI::Internal::Type::BaseModel
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
        #   @return [Array<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItem, OpenAI::Models::Responses::ResponseItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseItem::Program, OpenAI::Models::Responses::ResponseItem::ProgramOutput, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseItem::LocalShellCall, OpenAI::Models::Responses::ResponseItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseItem::McpListTools, OpenAI::Models::Responses::ResponseItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallItem, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem>]
        required :output, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseItem] }

        # @!attribute usage
        #   Token accounting for the compaction pass, including cached, reasoning, and total
        #   tokens.
        #
        #   @return [OpenAI::Models::Responses::ResponseUsage]
        required :usage, -> { OpenAI::Responses::ResponseUsage }

        # @!method initialize(id:, created_at:, output:, usage:, object: :"response.compaction")
        #   @param id [String]
        #     The unique identifier for the compacted response.
        #
        #   @param created_at [Integer]
        #     Unix timestamp (in seconds) when the compacted conversation was created.
        #
        #   @param output [Array<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItem, OpenAI::Models::Responses::ResponseItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseItem::Program, OpenAI::Models::Responses::ResponseItem::ProgramOutput, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseItem::LocalShellCall, OpenAI::Models::Responses::ResponseItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseItem::McpListTools, OpenAI::Models::Responses::ResponseItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallItem, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem>]
        #     The compacted list of output items. This is a list of all user messages,
        #     followed by a single compaction item.
        #
        #   @param usage [OpenAI::Models::Responses::ResponseUsage]
        #     Token accounting for the compaction pass, including cached, reasoning, and total
        #     tokens.
        #
        #   @param object [Symbol, :"response.compaction"]
        #     The object type. Always `response.compaction`.
      end
    end
  end
end
