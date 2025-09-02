# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferTimeoutTriggered < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_end_ms
        #   Millisecond offset where speech ended within the buffered audio.
        #
        #   @return [Integer]
        required :audio_end_ms, Integer

        # @!attribute audio_start_ms
        #   Millisecond offset where speech started within the buffered audio.
        #
        #   @return [Integer]
        required :audio_start_ms, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item associated with this segment.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.timeout_triggered`.
        #
        #   @return [Symbol, :"input_audio_buffer.timeout_triggered"]
        required :type, const: :"input_audio_buffer.timeout_triggered"

        # @!method initialize(audio_end_ms:, audio_start_ms:, event_id:, item_id:, type: :"input_audio_buffer.timeout_triggered")
        #   Returned when the server VAD timeout is triggered for the input audio buffer.
        #
        #   @param audio_end_ms [Integer] Millisecond offset where speech ended within the buffered audio.
        #
        #   @param audio_start_ms [Integer] Millisecond offset where speech started within the buffered audio.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item associated with this segment.
        #
        #   @param type [Symbol, :"input_audio_buffer.timeout_triggered"] The event type, must be `input_audio_buffer.timeout_triggered`.
      end
    end
  end
end
