# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the item's content array.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute response_id
        #   The ID of the response.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute text
        #   The final text content.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The event type, must be `response.output_text.done`.
        #
        #   @return [Symbol, :"response.output_text.done"]
        required :type, const: :"response.output_text.done"

        # @!method initialize(content_index:, event_id:, item_id:, output_index:, response_id:, text:, type: :"response.output_text.done")
        #   Returned when the text value of an "output_text" content part is done streaming.
        #   Also emitted when a Response is interrupted, incomplete, or cancelled.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param text [String] The final text content.
        #
        #   @param type [Symbol, :"response.output_text.done"] The event type, must be `response.output_text.done`.
      end
    end
  end
end
