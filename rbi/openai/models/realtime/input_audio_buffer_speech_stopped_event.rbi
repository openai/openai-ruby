# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferSpeechStoppedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferSpeechStoppedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Milliseconds since the session started when speech stopped. This will correspond
        # to the end of audio sent to the model, and thus includes the
        # `min_silence_duration_ms` configured in the Session.
        sig { returns(Integer) }
        attr_accessor :audio_end_ms

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the user message item that will be created.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `input_audio_buffer.speech_stopped`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned in `server_vad` mode when the server detects the end of speech in the
        # audio buffer. The server will also send an `conversation.item.created` event
        # with the user message item that is created from the audio buffer.
        sig do
          params(
            audio_end_ms: Integer,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Milliseconds since the session started when speech stopped. This will correspond
          # to the end of audio sent to the model, and thus includes the
          # `min_silence_duration_ms` configured in the Session.
          audio_end_ms:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the user message item that will be created.
          item_id:,
          # The event type, must be `input_audio_buffer.speech_stopped`.
          type: :"input_audio_buffer.speech_stopped"
        )
        end

        sig do
          override.returns(
            {
              audio_end_ms: Integer,
              event_id: String,
              item_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
