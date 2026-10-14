# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The session that started processing.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.in_progress`.
        #
        #   @return [Symbol, :"agent.session.in_progress"]
        required :type, const: :"agent.session.in_progress"

        # @!method initialize(event_id:, session:, type: :"agent.session.in_progress")
        #   Emitted when a session starts processing a turn.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The session that started processing.
        #
        #   @param type [Symbol, :"agent.session.in_progress"]
        #     The type of the object. Always `agent.session.in_progress`.
      end
    end
  end
end
