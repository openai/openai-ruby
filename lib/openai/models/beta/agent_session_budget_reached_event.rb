# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionBudgetReachedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The paused session.
        #
        #   @return [OpenAI::Models::Beta::AgentSession]
        required :session, -> { OpenAI::Beta::AgentSession }

        # @!attribute type
        #   The type of the object. Always `agent.session.budget_reached`.
        #
        #   @return [Symbol, :"agent.session.budget_reached"]
        required :type, const: :"agent.session.budget_reached"

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, session:, obfuscation: nil, type: :"agent.session.budget_reached")
        #   Emitted when a session pauses because its spending limit was reached.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session [OpenAI::Models::Beta::AgentSession]
        #     The paused session.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.budget_reached"]
        #     The type of the object. Always `agent.session.budget_reached`.
      end
    end
  end
end
