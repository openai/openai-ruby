# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnCreatedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The turn at the time it was created.
        #
        #   @return [OpenAI::Models::Beta::Agents::Sessions::Turn]
        required :turn, -> { OpenAI::Beta::Agents::Sessions::Turn }

        # @!attribute turn_id
        #   The ID of the turn associated with the event.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.created`.
        #
        #   @return [Symbol, :"agent.session.turn.created"]
        required :type, const: :"agent.session.turn.created"

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, session_id:, turn:, turn_id:, obfuscation: nil, type: :"agent.session.turn.created")
        #   Emitted when a turn is created.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn [OpenAI::Models::Beta::Agents::Sessions::Turn]
        #     The turn at the time it was created.
        #
        #   @param turn_id [String]
        #     The ID of the turn associated with the event.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.turn.created"]
        #     The type of the object. Always `agent.session.turn.created`.
      end
    end
  end
end
