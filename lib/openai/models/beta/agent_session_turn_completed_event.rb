# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn
        #   The completed turn.
        #
        #   @return [OpenAI::Models::Beta::Agents::Sessions::Turn]
        required :turn, -> { OpenAI::Beta::Agents::Sessions::Turn }

        # @!attribute turn_id
        #   The ID of the turn associated with the event.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.completed`.
        #
        #   @return [Symbol, :"agent.session.turn.completed"]
        required :type, const: :"agent.session.turn.completed"

        # @!attribute usage
        #   Recorded token usage for a session or turn. Usage is best effort and may change.
        #
        #   @return [OpenAI::Models::Beta::TokenUsage, nil]
        required :usage, -> { OpenAI::Beta::TokenUsage }, nil?: true

        # @!method initialize(event_id:, session_id:, turn:, turn_id:, usage:, type: :"agent.session.turn.completed")
        #   Emitted when a turn completes.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn [OpenAI::Models::Beta::Agents::Sessions::Turn]
        #     The completed turn.
        #
        #   @param turn_id [String]
        #     The ID of the turn associated with the event.
        #
        #   @param usage [OpenAI::Models::Beta::TokenUsage, nil]
        #     Recorded token usage for a session or turn. Usage is best effort and may change.
        #
        #   @param type [Symbol, :"agent.session.turn.completed"]
        #     The type of the object. Always `agent.session.turn.completed`.
      end
    end
  end
end
