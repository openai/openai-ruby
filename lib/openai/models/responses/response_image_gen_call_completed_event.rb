# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseImageGenCallCompletedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always 'response.image_generation_call.completed'.
        #
        #   @return [Symbol, :"response.image_generation_call.completed"]
        required :type, const: :"response.image_generation_call.completed"

        # @!method initialize(item_id:, output_index:, type: :"response.image_generation_call.completed")
        #   Emitted when an image generation tool call has completed and the final image is
        #   available.
        #
        #   @param item_id [String] The unique identifier of the image generation item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param type [Symbol, :"response.image_generation_call.completed"] The type of the event. Always 'response.image_generation_call.completed'.
      end
    end
  end
end
