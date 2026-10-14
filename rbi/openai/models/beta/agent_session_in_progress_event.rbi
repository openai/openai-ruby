# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionInProgressEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionInProgressEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The session that started processing.
        sig { returns(OpenAI::Beta::AgentSession) }
        attr_reader :session

        sig { params(session: OpenAI::Beta::AgentSession::OrHash).void }
        attr_writer :session

        # The type of the object. Always `agent.session.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a session starts processing a turn.
        sig do
          params(

            event_id: String,

            session: OpenAI::Beta::AgentSession::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The session that started processing.
          session:,

          # The type of the object. Always `agent.session.in_progress`.

          type: :"agent.session.in_progress"
        )
        end

        sig do
          override.returns(
            {event_id: String, session: OpenAI::Beta::AgentSession, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
