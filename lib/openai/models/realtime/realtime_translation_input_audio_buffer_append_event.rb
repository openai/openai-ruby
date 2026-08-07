# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationInputAudioBufferAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Base64-encoded 24 kHz PCM16 mono audio bytes.
        #
        #   @return [String]
        required :audio, String

        # @!attribute type
        #   The event type, must be `session.input_audio_buffer.append`.
        #
        #   @return [Symbol, :"session.input_audio_buffer.append"]
        required :type, const: :"session.input_audio_buffer.append"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(audio:, event_id: nil, type: :"session.input_audio_buffer.append")
        #   Send this event to append audio bytes to the translation session input audio
        #   buffer.
        #
        #   WebSocket translation sessions accept base64-encoded 24 kHz PCM16 mono
        #   little-endian raw audio bytes. Unsupported websocket audio formats return a
        #   validation error because lower-quality audio materially degrades translation
        #   quality.
        #
        #   Translation consumes 200 ms engine frames. For best realtime behavior, append
        #   audio in 200 ms chunks. If a chunk is shorter, the server buffers it until it
        #   has enough audio for one frame. If a chunk is longer, the server splits it into
        #   200 ms frames and enqueues them back-to-back.
        #
        #   Keep appending silence while the session is active. If a client stops sending
        #   audio and later resumes, model time treats the resumed audio as contiguous with
        #   the previous audio rather than as a real-world pause.
        #
        #   @param audio [String] Base64-encoded 24 kHz PCM16 mono audio bytes.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"session.input_audio_buffer.append"] The event type, must be `session.input_audio_buffer.append`.
      end
    end
  end
end
