# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was marked done.
        #
        #   @return [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseCustomToolCall]
        required :item, union: -> { OpenAI::Responses::ResponseOutputItem }

        # @!attribute output_index
        #   The index of the output item that was marked done.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_item.done`.
        #
        #   @return [Symbol, :"response.output_item.done"]
        required :type, const: :"response.output_item.done"

        # @!method initialize(item:, output_index:, sequence_number:, type: :"response.output_item.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseOutputItemDoneEvent} for more details.
        #
        #   Emitted when an output item is marked done.
        #
        #   @param item [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseCustomToolCall] The output item that was marked done.
        #
        #   @param output_index [Integer] The index of the output item that was marked done.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.output_item.done"] The type of the event. Always `response.output_item.done`.
      end
    end
  end
end
