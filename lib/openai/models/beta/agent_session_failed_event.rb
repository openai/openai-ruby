# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The failed session.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.failed`.
        #
        #   @return [Symbol, :"agent.session.failed"]
        required :type, const: :"agent.session.failed"

        # @!method initialize(event_id:, session:, type: :"agent.session.failed")
        #   Emitted when a session fails.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The failed session.
        #
        #   @param type [Symbol, :"agent.session.failed"]
        #     The type of the object. Always `agent.session.failed`.
      end
    end
  end
end
