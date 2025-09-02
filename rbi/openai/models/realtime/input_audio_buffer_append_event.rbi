# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferAppendEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferAppendEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Base64-encoded audio bytes. This must be in the format specified by the
        # `input_audio_format` field in the session configuration.
        sig { returns(String) }
        attr_accessor :audio

        # The event type, must be `input_audio_buffer.append`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to append audio bytes to the input audio buffer. The audio
        # buffer is temporary storage you can write to and later commit. In Server VAD
        # mode, the audio buffer is used to detect speech and the server will decide when
        # to commit. When Server VAD is disabled, you must commit the audio buffer
        # manually.
        #
        # The client may choose how much audio to place in each event up to a maximum of
        # 15 MiB, for example streaming smaller chunks from the client may allow the VAD
        # to be more responsive. Unlike made other client events, the server will not send
        # a confirmation response to this event.
        sig do
          params(audio: String, event_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Base64-encoded audio bytes. This must be in the format specified by the
          # `input_audio_format` field in the session configuration.
          audio:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `input_audio_buffer.append`.
          type: :"input_audio_buffer.append"
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
