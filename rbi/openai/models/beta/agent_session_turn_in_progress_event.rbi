# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionTurnInProgressEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionTurnInProgressEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The turn at the time it started running.
        sig { returns(OpenAI::Beta::Agents::Sessions::Turn) }
        attr_reader :turn

        sig { params(turn: OpenAI::Beta::Agents::Sessions::Turn::OrHash).void }
        attr_writer :turn

        # The ID of the turn associated with the event.
        sig { returns(String) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.turn.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a turn starts running.
        sig do
          params(

            event_id: String,

            session_id: String,

            turn: OpenAI::Beta::Agents::Sessions::Turn::OrHash,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The ID of the session associated with the event.
          session_id:,

          # The turn at the time it started running.
          turn:,

          # The ID of the turn associated with the event.
          turn_id:,

          # The type of the object. Always `agent.session.turn.in_progress`.

          type: :"agent.session.turn.in_progress"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session_id: String,
              turn: OpenAI::Beta::Agents::Sessions::Turn,
              turn_id: String,
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
