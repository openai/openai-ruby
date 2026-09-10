# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The session that was created.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.created`.
        #
        #   @return [Symbol, :"agent.session.created"]
        required :type, const: :"agent.session.created"

        # @!method initialize(event_id:, session:, type: :"agent.session.created")
        #   Emitted when a session is created.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The session that was created.
        #
        #   @param type [Symbol, :"agent.session.created"]
        #     The type of the object. Always `agent.session.created`.
      end
    end
  end
end
