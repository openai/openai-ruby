# typed: strong

module OpenAI
  module Models

    module Live

      class InputAudioMutedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::InputAudioMutedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, always `session.input_audio.muted`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Returned when a session.input_audio.mute command is accepted. Input audio is no
        # longer sent to the model; sideband audio reflection continues.
        sig do
          params(

            event_id: String,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `session.input_audio.muted`.

          type: :"session.input_audio.muted"
        )
        end

        sig do
          override.returns(
            {event_id: String, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
