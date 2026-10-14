# typed: strong

module OpenAI
  module Models

    module Live

      class InputAudioUnmuteEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::InputAudioUnmuteEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The Live client event type. Always `session.input_audio.unmute`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Resume audio input to a Live model after muting it. The server acknowledges with
        # `session.input_audio.unmuted`.
        sig do
          params(

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.input_audio.unmute`.

          type: :"session.input_audio.unmute"
        )
        end

        sig do
          override.returns(
            {type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
