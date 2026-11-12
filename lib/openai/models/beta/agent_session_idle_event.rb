# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionIdleEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The session that became idle.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.idle`.
        #
        #   @return [Symbol, :"agent.session.idle"]
        required :type, const: :"agent.session.idle"

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, session:, obfuscation: nil, type: :"agent.session.idle")
        #   Emitted when a session becomes idle.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The session that became idle.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.idle"]
        #     The type of the object. Always `agent.session.idle`.
      end
    end
  end
end
