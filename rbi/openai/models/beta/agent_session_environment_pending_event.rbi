# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionEnvironmentPendingEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionEnvironmentPendingEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The current environment state.
        sig { returns(OpenAI::Beta::AgentSessionEnvironmentState) }
        attr_reader :environment

        sig { params(environment: OpenAI::Beta::AgentSessionEnvironmentState::OrHash).void }
        attr_writer :environment

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The ID of the turn associated with the event, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.environment.pending`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted while a session environment is being prepared.
        sig do
          params(

            environment: OpenAI::Beta::AgentSessionEnvironmentState::OrHash,

            event_id: String,

            session_id: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The current environment state.
          environment:,

          # The unique ID of the event.
          event_id:,

          # The ID of the session associated with the event.
          session_id:,

          # The ID of the turn associated with the event, when applicable.
          turn_id:,

          # The type of the object. Always `agent.session.environment.pending`.

          type: :"agent.session.environment.pending"
        )
        end

        sig do
          override.returns(
            {
              environment: OpenAI::Beta::AgentSessionEnvironmentState,
              event_id: String,
              session_id: String,
              turn_id: T.nilable(String),
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
