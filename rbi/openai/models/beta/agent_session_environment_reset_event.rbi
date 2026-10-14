# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionEnvironmentResetEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionEnvironmentResetEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The stable environment ID, retained across sandbox replacements.
        sig { returns(String) }
        attr_accessor :environment_id

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # Monotonically increasing reset number. Repeated notifications share this number.
        sig { returns(Integer) }
        attr_accessor :reset_count

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The associated turn, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.environment.reset`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted after a hosted sandbox is replaced. Conversation history survives;
        # changes to the previous sandbox's files and processes do not.
        sig do
          params(

            environment_id: String,

            event_id: String,

            reset_count: Integer,

            session_id: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The stable environment ID, retained across sandbox replacements.
          environment_id:,

          # The unique ID of the event.
          event_id:,

          # Monotonically increasing reset number. Repeated notifications share this number.
          reset_count:,

          # The ID of the session associated with the event.
          session_id:,

          # The associated turn, when applicable.
          turn_id:,

          # The type of the object. Always `agent.session.environment.reset`.

          type: :"agent.session.environment.reset"
        )
        end

        sig do
          override.returns(
            {
              environment_id: String,
              event_id: String,
              reset_count: Integer,
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
