# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was marked done.
        #
        #   @return [OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Responses::ResponseOutputItem::McpCall, OpenAI::Responses::ResponseOutputItem::McpListTools, OpenAI::Responses::ResponseOutputItem::McpApprovalRequest]
        required :item, union: -> { OpenAI::Responses::ResponseOutputItem }

        # @!attribute output_index
        #   The index of the output item that was marked done.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_item.done`.
        #
        #   @return [Symbol, :"response.output_item.done"]
        required :type, const: :"response.output_item.done"

        # @!method initialize(item:, output_index:, type: :"response.output_item.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseOutputItemDoneEvent} for more details.
        #
        #   Emitted when an output item is marked done.
        #
        #   @param item [OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Responses::ResponseOutputItem::McpCall, OpenAI::Responses::ResponseOutputItem::McpListTools, OpenAI::Responses::ResponseOutputItem::McpApprovalRequest] The output item that was marked done.
        #
        #   @param output_index [Integer] The index of the output item that was marked done.
        #
        #   @param type [Symbol, :"response.output_item.done"] The type of the event. Always `response.output_item.done`.
      end
    end
  end
end
