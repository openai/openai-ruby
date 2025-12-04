# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was added.
        #
        #   @return [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseCustomToolCall]
        required :item, union: -> { OpenAI::Responses::ResponseOutputItem }

        # @!attribute output_index
        #   The index of the output item that was added.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_item.added`.
        #
        #   @return [Symbol, :"response.output_item.added"]
        required :type, const: :"response.output_item.added"

        # @!method initialize(item:, output_index:, sequence_number:, type: :"response.output_item.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseOutputItemAddedEvent} for more details.
        #
        #   Emitted when a new output item is added.
        #
        #   @param item [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseCustomToolCall] The output item that was added.
        #
        #   @param output_index [Integer] The index of the output item that was added.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.output_item.added"] The type of the event. Always `response.output_item.added`.
      end
    end
  end
end
