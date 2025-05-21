# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was added.
        #
        #   @return [OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Responses::ResponseOutputItem::McpCall, OpenAI::Responses::ResponseOutputItem::McpListTools, OpenAI::Responses::ResponseOutputItem::McpApprovalRequest]
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
        #   {OpenAI::Responses::ResponseOutputItemAddedEvent} for more details.
        #
        #   Emitted when a new output item is added.
        #
        #   @param item [OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Responses::ResponseOutputItem::McpCall, OpenAI::Responses::ResponseOutputItem::McpListTools, OpenAI::Responses::ResponseOutputItem::McpApprovalRequest] The output item that was added.
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
