# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferClearEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferClearEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `input_audio_buffer.clear`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to clear the audio bytes in the buffer. The server will respond
        # with an `input_audio_buffer.cleared` event.
        sig { params(event_id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `input_audio_buffer.clear`.
          type: :"input_audio_buffer.clear"
        )
        end

        sig { override.returns({ type: Symbol, event_id: String }) }
        def to_hash
        end
      end
    end
  end
end
