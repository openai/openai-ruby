# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentResumeSubagentCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute recipient_agent_id
        #   The ID of the agent to resume.
        #
        #   @return [String]
        required :recipient_agent_id, String

        # @!attribute sender_agent_id
        #   The ID of the agent requesting the resume.
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
        #   The item type. Always `resume_subagent_call`.
        #
        #   @return [Symbol, :resume_subagent_call]
        required :type, const: :resume_subagent_call

        # @!method initialize(id:, recipient_agent_id:, sender_agent_id:, status:, turn_id:, type: :resume_subagent_call)
        #   A request to resume a subagent.
        #
        #   @param id [String]
        #     The ID of the tool call item.
        #
        #   @param recipient_agent_id [String]
        #     The ID of the agent to resume.
        #
        #   @param sender_agent_id [String]
        #     The ID of the agent requesting the resume.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :resume_subagent_call]
        #     The item type. Always `resume_subagent_call`.
      end
    end
  end
end
