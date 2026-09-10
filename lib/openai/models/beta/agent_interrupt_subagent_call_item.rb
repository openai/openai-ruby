# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentInterruptSubagentCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute recipient_agent_id
        #   The ID of the agent to interrupt.
        #
        #   @return [String]
        required :recipient_agent_id, String

        # @!attribute sender_agent_id
        #   The ID of the agent requesting the interrupt.
        #
        #   @return [String]
        required :sender_agent_id, String

        # @!attribute status
        #   The status of the tool call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `interrupt_subagent_call`.
        #
        #   @return [Symbol, :interrupt_subagent_call]
        required :type, const: :interrupt_subagent_call

        # @!method initialize(id:, recipient_agent_id:, sender_agent_id:, status:, turn_id:, type: :interrupt_subagent_call)
        #   A request to interrupt a subagent's current turn. The subagent remains
        #   available.
        #
        #   @param id [String]
        #     The ID of the tool call item.
        #
        #   @param recipient_agent_id [String]
        #     The ID of the agent to interrupt.
        #
        #   @param sender_agent_id [String]
        #     The ID of the agent requesting the interrupt.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :interrupt_subagent_call]
        #     The item type. Always `interrupt_subagent_call`.
      end
    end
  end
end
