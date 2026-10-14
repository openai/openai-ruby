# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationInputAudioBufferAppendEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Base64-encoded 24 kHz PCM16 mono audio bytes.
        sig { returns(String) }
        attr_accessor :audio

        # The event type, must be `session.input_audio_buffer.append`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to append audio bytes to the translation session input audio
        # buffer.
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
        sig do
          params(audio: String, event_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Base64-encoded 24 kHz PCM16 mono audio bytes.
          audio:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `session.input_audio_buffer.append`.
          type: :"session.input_audio_buffer.append"
        )
        end

        sig do
          override.returns({ audio: String, type: Symbol, event_id: String })
        end
        def to_hash
        end
      end
    end
  end
end
