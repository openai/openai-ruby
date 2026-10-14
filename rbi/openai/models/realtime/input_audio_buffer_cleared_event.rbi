# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferClearedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferClearedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `input_audio_buffer.cleared`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the input audio buffer is cleared by the client with a
        # `input_audio_buffer.clear` event.
        sig { params(event_id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The event type, must be `input_audio_buffer.cleared`.
          type: :"input_audio_buffer.cleared"
        )
        end

        sig { override.returns({ event_id: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
