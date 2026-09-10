# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnInProgressEvent < OpenAI::Internal::Type::BaseModel
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
        #   The turn at the time it started running.
        #
        #   @return [OpenAI::Models::Beta::Agents::Sessions::Turn]
        required :turn, -> { OpenAI::Beta::Agents::Sessions::Turn }

        # @!attribute turn_id
        #   The ID of the turn associated with the event.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.in_progress`.
        #
        #   @return [Symbol, :"agent.session.turn.in_progress"]
        required :type, const: :"agent.session.turn.in_progress"

        # @!method initialize(event_id:, session_id:, turn:, turn_id:, type: :"agent.session.turn.in_progress")
        #   Emitted when a turn starts running.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn [OpenAI::Models::Beta::Agents::Sessions::Turn]
        #     The turn at the time it started running.
        #
        #   @param turn_id [String]
        #     The ID of the turn associated with the event.
        #
        #   @param type [Symbol, :"agent.session.turn.in_progress"]
        #     The type of the object. Always `agent.session.turn.in_progress`.
      end
    end
  end
end
