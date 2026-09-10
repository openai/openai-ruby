# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionTurnCancelledEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionTurnCancelledEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The cancelled turn.
        sig { returns(OpenAI::Beta::Agents::Sessions::Turn) }
        attr_reader :turn

        sig { params(turn: OpenAI::Beta::Agents::Sessions::Turn::OrHash).void }
        attr_writer :turn

        # The ID of the turn associated with the event.
        sig { returns(String) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.turn.cancelled`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Recorded token usage for a session or turn. Usage is best effort and may change.
        sig { returns(T.nilable(OpenAI::Beta::TokenUsage)) }
        attr_reader :usage

        sig { params(usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash)).void }
        attr_writer :usage

        # Emitted when a turn is cancelled.
        sig do
          params(

            event_id: String,

            session_id: String,

            turn: OpenAI::Beta::Agents::Sessions::Turn::OrHash,

            turn_id: String,

            usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The ID of the session associated with the event.
          session_id:,

          # The cancelled turn.
          turn:,

          # The ID of the turn associated with the event.
          turn_id:,

          # Recorded token usage for a session or turn. Usage is best effort and may change.
          usage:,

          # The type of the object. Always `agent.session.turn.cancelled`.

          type: :"agent.session.turn.cancelled"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session_id: String,
              turn: OpenAI::Beta::Agents::Sessions::Turn,
              turn_id: String,
              type: Symbol,
              usage: T.nilable(OpenAI::Beta::TokenUsage)
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
