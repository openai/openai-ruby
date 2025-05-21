# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseImageGenCallPartialImageEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute partial_image_b64
        #   Base64-encoded partial image data, suitable for rendering as an image.
        #
        #   @return [String]
        required :partial_image_b64, String

        # @!attribute partial_image_index
        #   0-based index for the partial image (backend is 1-based, but this is 0-based for
        #   the user).
        #
        #   @return [Integer]
        required :partial_image_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the image generation item being processed.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.image_generation_call.partial_image'.
        #
        #   @return [Symbol, :"response.image_generation_call.partial_image"]
        required :type, const: :"response.image_generation_call.partial_image"

        # @!method initialize(item_id:, output_index:, partial_image_b64:, partial_image_index:, sequence_number:, type: :"response.image_generation_call.partial_image")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseImageGenCallPartialImageEvent} for more details.
        #
        #   Emitted when a partial image is available during image generation streaming.
        #
        #   @param item_id [String] The unique identifier of the image generation item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param partial_image_b64 [String] Base64-encoded partial image data, suitable for rendering as an image.
        #
        #   @param partial_image_index [Integer] 0-based index for the partial image (backend is 1-based, but this is 0-based for
        #
        #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
        #
        #   @param type [Symbol, :"response.image_generation_call.partial_image"] The type of the event. Always 'response.image_generation_call.partial_image'.
      end
    end
  end
end
