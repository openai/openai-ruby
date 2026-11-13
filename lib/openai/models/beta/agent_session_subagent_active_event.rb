# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionSubagentActiveEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute subagent
        #   The subagent that resumed.
        #
        #   @return [OpenAI::Models::Beta::Subagent]
        required :subagent, -> { OpenAI::Beta::Subagent }

        # @!attribute type
        #   The type of the object. Always `agent.session.subagent.active`.
        #
        #   @return [Symbol, :"agent.session.subagent.active"]
        required :type, const: :"agent.session.subagent.active"

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(event_id:, subagent:, obfuscation: nil, type: :"agent.session.subagent.active")
        #   Emitted when a closed subagent successfully resumes.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param subagent [OpenAI::Models::Beta::Subagent]
        #     The subagent that resumed.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :"agent.session.subagent.active"]
        #     The type of the object. Always `agent.session.subagent.active`.
      end
    end
  end
end
