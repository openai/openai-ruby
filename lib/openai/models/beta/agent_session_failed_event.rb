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

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, session:, obfuscation: nil, type: :"agent.session.failed")
        #   Emitted when a session fails.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The failed session.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.failed"]
        #     The type of the object. Always `agent.session.failed`.
      end
    end
  end
end
