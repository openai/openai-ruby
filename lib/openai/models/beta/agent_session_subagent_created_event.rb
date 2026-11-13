# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionSubagentCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute subagent
        #   The subagent that was created.
        #
        #   @return [OpenAI::Models::Beta::Subagent]
        required :subagent, -> { OpenAI::Beta::Subagent }

        # @!attribute type
        #   The type of the object. Always `agent.session.subagent.created`.
        #
        #   @return [Symbol, :"agent.session.subagent.created"]
        required :type, const: :"agent.session.subagent.created"

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, subagent:, obfuscation: nil, type: :"agent.session.subagent.created")
        #   Emitted when a subagent is created.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param subagent [OpenAI::Models::Beta::Subagent]
        #     The subagent that was created.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.subagent.created"]
        #     The type of the object. Always `agent.session.subagent.created`.
      end
    end
  end
end
