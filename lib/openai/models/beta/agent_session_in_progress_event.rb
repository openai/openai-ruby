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

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, session:, obfuscation: nil, type: :"agent.session.in_progress")
        #   Emitted when a session starts processing a turn.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The session that started processing.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.in_progress"]
        #     The type of the object. Always `agent.session.in_progress`.
      end
    end
  end
end
