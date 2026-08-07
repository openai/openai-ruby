# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # A Realtime translation client event.
      module RealtimeTranslationClientEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Send this event to update the translation session configuration. Translation
        # sessions support updates to `audio.output.language`, `audio.input.transcription`,
        # and `audio.input.noise_reduction`.
        variant :"session.update", -> { OpenAI::Realtime::RealtimeTranslationSessionUpdateEvent }

        # Send this event to append audio bytes to the translation session input audio buffer.
        #
        # WebSocket translation sessions accept base64-encoded 24 kHz PCM16 mono
        # little-endian raw audio bytes. Unsupported websocket audio formats return a
        # validation error because lower-quality audio materially degrades translation
        # quality.
        #
        # Translation consumes 200 ms engine frames. For best realtime behavior, append
        # audio in 200 ms chunks. If a chunk is shorter, the server buffers it until it
        # has enough audio for one frame. If a chunk is longer, the server splits it into
        # 200 ms frames and enqueues them back-to-back.
        #
        # Keep appending silence while the session is active. If a client stops sending
        # audio and later resumes, model time treats the resumed audio as contiguous with
        # the previous audio rather than as a real-world pause.
        variant :"session.input_audio_buffer.append",
                -> { OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent }

        # Gracefully close the realtime translation session. The server flushes pending
        # input audio and emits any remaining translated output before closing the
        # session.
        variant :"session.close", -> { OpenAI::Realtime::RealtimeTranslationSessionCloseEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateEvent, OpenAI::Models::Realtime::RealtimeTranslationInputAudioBufferAppendEvent, OpenAI::Models::Realtime::RealtimeTranslationSessionCloseEvent)]
      end
    end
  end
end
