# typed: strong

module OpenAI
  module Models
    module Realtime
      class SessionCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::SessionCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # Realtime session object.
        sig { returns(OpenAI::Realtime::RealtimeSession) }
        attr_reader :session

        sig { params(session: OpenAI::Realtime::RealtimeSession::OrHash).void }
        attr_writer :session

        # The event type, must be `session.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a Session is created. Emitted automatically when a new connection
        # is established as the first server event. This event will contain the default
        # Session configuration.
        sig do
          params(
            event_id: String,
            session: OpenAI::Realtime::RealtimeSession::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # Realtime session object.
          session:,
          # The event type, must be `session.created`.
          type: :"session.created"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session: OpenAI::Realtime::RealtimeSession,
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
