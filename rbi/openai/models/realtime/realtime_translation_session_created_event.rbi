# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The translation session configuration.
        sig { returns(OpenAI::Realtime::RealtimeTranslationSession) }
        attr_reader :session

        sig do
          params(
            session: OpenAI::Realtime::RealtimeTranslationSession::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `session.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a translation session is created. Emitted automatically when a new
        # connection is established as the first server event. This event contains the
        # default translation session configuration.
        sig do
          params(
            event_id: String,
            session: OpenAI::Realtime::RealtimeTranslationSession::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The translation session configuration.
          session:,
          # The event type, must be `session.created`.
          type: :"session.created"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session: OpenAI::Realtime::RealtimeTranslationSession,
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
