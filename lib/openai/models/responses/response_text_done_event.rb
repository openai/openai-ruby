# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the text content is finalized.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the text content is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the text content is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute text
        #   The text content that is finalized.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.output_text.done`.
        #
        #   @return [Symbol, :"response.output_text.done"]
        required :type, const: :"response.output_text.done"

        # @!method initialize(content_index:, item_id:, output_index:, sequence_number:, text:, type: :"response.output_text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseTextDoneEvent} for more details.
        #
        #   Emitted when text content is finalized.
        #
        #   @param content_index [Integer] The index of the content part that the text content is finalized.
        #
        #   @param item_id [String] The ID of the output item that the text content is finalized.
        #
        #   @param output_index [Integer] The index of the output item that the text content is finalized.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param text [String] The text content that is finalized.
        #
        #   @param type [Symbol, :"response.output_text.done"] The type of the event. Always `response.output_text.done`.
      end
    end
  end
end
