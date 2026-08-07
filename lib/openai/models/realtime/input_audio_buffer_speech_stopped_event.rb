# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferSpeechStoppedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_end_ms
        #   Milliseconds since the session started when speech stopped. This will correspond
        #   to the end of audio sent to the model, and thus includes the
        #   `min_silence_duration_ms` configured in the Session.
        #
        #   @return [Integer]
        required :audio_end_ms, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the user message item that will be created.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.speech_stopped`.
        #
        #   @return [Symbol, :"input_audio_buffer.speech_stopped"]
        required :type, const: :"input_audio_buffer.speech_stopped"

        # @!method initialize(audio_end_ms:, event_id:, item_id:, type: :"input_audio_buffer.speech_stopped")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferSpeechStoppedEvent} for more details.
        #
        #   Returned in `server_vad` mode when the server detects the end of speech in the
        #   audio buffer. The server will also send an `conversation.item.created` event
        #   with the user message item that is created from the audio buffer.
        #
        #   @param audio_end_ms [Integer] Milliseconds since the session started when speech stopped. This will
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the user message item that will be created.
        #
        #   @param type [Symbol, :"input_audio_buffer.speech_stopped"] The event type, must be `input_audio_buffer.speech_stopped`.
      end
    end
  end
end
