# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionCreatedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionCreatedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The session that was created.
        sig { returns(OpenAI::Beta::AgentSession) }
        attr_reader :session

        sig { params(session: OpenAI::Beta::AgentSession::OrHash).void }
        attr_writer :session

        # The type of the object. Always `agent.session.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Random alphanumeric padding. Present when stream obfuscation is enabled.
        sig { returns(T.nilable(String)) }
        attr_reader :obfuscation

        sig { params(obfuscation: String).void }
        attr_writer :obfuscation

        # Emitted when a session is created.
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

          # The session that was created.
          session:,

          # Random alphanumeric padding. Present when stream obfuscation is enabled.
          obfuscation: nil,

          # The type of the object. Always `agent.session.created`.

          type: :"agent.session.created"
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
