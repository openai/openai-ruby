# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionRequiresActionEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The session and its current required actions.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.requires_action`.
        #
        #   @return [Symbol, :"agent.session.requires_action"]
        required :type, const: :"agent.session.requires_action"

        # @!method initialize(event_id:, session:, type: :"agent.session.requires_action")
        #   Emitted when a session is waiting for one or more required actions.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The session and its current required actions.
        #
        #   @param type [Symbol, :"agent.session.requires_action"]
        #     The type of the object. Always `agent.session.requires_action`.
      end
    end
  end
end
