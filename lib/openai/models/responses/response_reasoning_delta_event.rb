# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the reasoning content part within the output item.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The partial update to the reasoning content.
        #
        #   @return [Object]
        required :delta, OpenAI::Internal::Type::Unknown

        # @!attribute item_id
        #   The unique identifier of the item for which reasoning is being updated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.reasoning.delta'.
        #
        #   @return [Symbol, :"response.reasoning.delta"]
        required :type, const: :"response.reasoning.delta"

        # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, type: :"response.reasoning.delta")
        #   Emitted when there is a delta (partial update) to the reasoning content.
        #
        #   @param content_index [Integer] The index of the reasoning content part within the output item.
        #
        #   @param delta [Object] The partial update to the reasoning content.
        #
        #   @param item_id [String] The unique identifier of the item for which reasoning is being updated.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.reasoning.delta"] The type of the event. Always 'response.reasoning.delta'.
      end
    end
  end
end
