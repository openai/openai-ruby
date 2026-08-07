# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the item's content array.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The transcript delta.
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
        #   The event type, must be `response.output_audio_transcript.delta`.
        #
        #   @return [Symbol, :"response.output_audio_transcript.delta"]
        required :type, const: :"response.output_audio_transcript.delta"

        # @!method initialize(content_index:, delta:, event_id:, item_id:, output_index:, response_id:, type: :"response.output_audio_transcript.delta")
        #   Returned when the model-generated transcription of audio output is updated.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param delta [String] The transcript delta.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.output_audio_transcript.delta"] The event type, must be `response.output_audio_transcript.delta`.
      end
    end
  end
end
