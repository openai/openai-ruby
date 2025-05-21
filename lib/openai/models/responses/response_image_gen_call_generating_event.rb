# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseImageGenCallGeneratingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the image generation item being processed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always 'response.image_generation_call.generating'.
        #
        #   @return [Symbol, :"response.image_generation_call.generating"]
        required :type, const: :"response.image_generation_call.generating"

        # @!attribute sequence_number
        #   The sequence number of the image generation item being processed.
        #
        #   @return [Integer, nil]
        optional :sequence_number, Integer

        # @!method initialize(item_id:, output_index:, sequence_number: nil, type: :"response.image_generation_call.generating")
        #   Emitted when an image generation tool call is actively generating an image
        #   (intermediate state).
        #
        #   @param item_id [String] The unique identifier of the image generation item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
        #
        #   @param type [Symbol, :"response.image_generation_call.generating"] The type of the event. Always 'response.image_generation_call.generating'.
      end
    end
  end
end
