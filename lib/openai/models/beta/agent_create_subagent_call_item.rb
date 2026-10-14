# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentCreateSubagentCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute agent_id
        #   The ID of the agent that requested the subagent.
        #
        #   @return [String]
        required :agent_id, String

        # @!attribute content
        #   The task given to the spawned agent.
        #
        #   @return [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent] }

        # @!attribute model
        #   The model requested for the spawned agent.
        #
        #   @return [String, nil]
        required :model, String, nil?: true

        # @!attribute reasoning_effort
        #   The reasoning effort requested for the spawned agent.
        #
        #   @return [String, nil]
        required :reasoning_effort, String, nil?: true

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
        #   The item type. Always `create_subagent_call`.
        #
        #   @return [Symbol, :create_subagent_call]
        required :type, const: :create_subagent_call

        # @!method initialize(id:, agent_id:, content:, model:, reasoning_effort:, status:, turn_id:, type: :create_subagent_call)
        #   A request to spawn a subagent.
        #
        #   @param id [String]
        #     The ID of the tool call item.
        #
        #   @param agent_id [String]
        #     The ID of the agent that requested the subagent.
        #
        #   @param content [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
        #     The task given to the spawned agent.
        #
        #   @param model [String, nil]
        #     The model requested for the spawned agent.
        #
        #   @param reasoning_effort [String, nil]
        #     The reasoning effort requested for the spawned agent.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :create_subagent_call]
        #     The item type. Always `create_subagent_call`.
      end
    end
  end
end
