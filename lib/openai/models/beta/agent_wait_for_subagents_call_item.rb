# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentWaitForSubagentsCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute recipient_agent_ids
        #   The IDs of the agents to wait for.
        #
        #   @return [Array<String>]
        required :recipient_agent_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute sender_agent_id
        #   The ID of the agent waiting for results.
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
        #   The item type. Always `wait_for_subagents_call`.
        #
        #   @return [Symbol, :wait_for_subagents_call]
        required :type, const: :wait_for_subagents_call

        # @!method initialize(id:, recipient_agent_ids:, sender_agent_id:, status:, turn_id:, type: :wait_for_subagents_call)
        #   A request to wait for one or more subagents.
        #
        #   @param id [String]
        #     The ID of the tool call item.
        #
        #   @param recipient_agent_ids [Array<String>]
        #     The IDs of the agents to wait for.
        #
        #   @param sender_agent_id [String]
        #     The ID of the agent waiting for results.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :wait_for_subagents_call]
        #     The item type. Always `wait_for_subagents_call`.
      end
    end
  end
end
