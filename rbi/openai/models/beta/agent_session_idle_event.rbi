# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionIdleEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionIdleEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The session that became idle.
        sig { returns(OpenAI::Beta::AgentSession) }
        attr_reader :session

        sig { params(session: OpenAI::Beta::AgentSession::OrHash).void }
        attr_writer :session

        # The type of the object. Always `agent.session.idle`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Random alphanumeric padding. Present when stream obfuscation is enabled.
        sig { returns(T.nilable(String)) }
        attr_reader :obfuscation

        sig { params(obfuscation: String).void }
        attr_writer :obfuscation

        # Emitted when a session becomes idle.
        sig do
          params(

            event_id: String,

            session: OpenAI::Beta::AgentSession::OrHash,

            obfuscation: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The session that became idle.
          session:,

          # Random alphanumeric padding. Present when stream obfuscation is enabled.
          obfuscation: nil,

          # The type of the object. Always `agent.session.idle`.

          type: :"agent.session.idle"
        )
        end

        sig do
          override.returns(
            {event_id: String, session: OpenAI::Beta::AgentSession, type: Symbol, obfuscation: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
