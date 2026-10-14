# typed: strong

module OpenAI
  module Models

    module Live

      class SessionStartedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionStartedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The resolved Live session configuration and server-assigned session metadata.
        sig { returns(OpenAI::Live::SessionResource) }
        attr_reader :session

        sig { params(session: OpenAI::Live::SessionResource::OrHash).void }
        attr_writer :session

        # The event type, always `session.started`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Returned when a Live session has started. Contains the resolved session
        # configuration, including server defaults.
        sig do
          params(

            event_id: String,

            session: OpenAI::Live::SessionResource::OrHash,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          # The resolved Live session configuration and server-assigned session metadata.
          session:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `session.started`.

          type: :"session.started"
        )
        end

        sig do
          override.returns(
            {event_id: String, session: OpenAI::Live::SessionResource, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
