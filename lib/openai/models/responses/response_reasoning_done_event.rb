# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the reasoning content part within the output item.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The unique identifier of the item for which reasoning is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute text
        #   The finalized reasoning text.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always 'response.reasoning.done'.
        #
        #   @return [Symbol, :"response.reasoning.done"]
        required :type, const: :"response.reasoning.done"

        # @!method initialize(content_index:, item_id:, output_index:, text:, type: :"response.reasoning.done")
        #   Emitted when the reasoning content is finalized for an item.
        #
        #   @param content_index [Integer] The index of the reasoning content part within the output item.
        #
        #   @param item_id [String] The unique identifier of the item for which reasoning is finalized.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param text [String] The finalized reasoning text.
        #
        #   @param type [Symbol, :"response.reasoning.done"] The type of the event. Always 'response.reasoning.done'.
      end
    end
  end
end
