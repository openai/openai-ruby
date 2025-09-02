# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferTimeoutTriggered < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferTimeoutTriggered,
              OpenAI::Internal::AnyHash
            )
          end

        # Millisecond offset where speech ended within the buffered audio.
        sig { returns(Integer) }
        attr_accessor :audio_end_ms

        # Millisecond offset where speech started within the buffered audio.
        sig { returns(Integer) }
        attr_accessor :audio_start_ms

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item associated with this segment.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `input_audio_buffer.timeout_triggered`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the server VAD timeout is triggered for the input audio buffer.
        sig do
          params(
            audio_end_ms: Integer,
            audio_start_ms: Integer,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Millisecond offset where speech ended within the buffered audio.
          audio_end_ms:,
          # Millisecond offset where speech started within the buffered audio.
          audio_start_ms:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item associated with this segment.
          item_id:,
          # The event type, must be `input_audio_buffer.timeout_triggered`.
          type: :"input_audio_buffer.timeout_triggered"
        )
        end

        sig do
          override.returns(
            {
              audio_end_ms: Integer,
              audio_start_ms: Integer,
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
