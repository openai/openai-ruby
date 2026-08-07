# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the item's content array.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   Base64-encoded audio data delta.
        #
        #   @return [String]
        required :delta, String

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

        # @!attribute type
        #   The event type, must be `response.output_audio.delta`.
        #
        #   @return [Symbol, :"response.output_audio.delta"]
        required :type, const: :"response.output_audio.delta"

        # @!method initialize(content_index:, delta:, event_id:, item_id:, output_index:, response_id:, type: :"response.output_audio.delta")
        #   Returned when the model-generated audio is updated.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param delta [String] Base64-encoded audio data delta.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.output_audio.delta"] The event type, must be `response.output_audio.delta`.
      end
    end
  end
end
