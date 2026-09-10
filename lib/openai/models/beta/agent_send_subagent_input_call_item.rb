# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSendSubagentInputCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The input sent to the receiving agent.
        #
        #   @return [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent] }

        # @!attribute recipient_agent_id
        #   The ID of the agent receiving the input.
        #
        #   @return [String]
        required :recipient_agent_id, String

        # @!attribute sender_agent_id
        #   The ID of the agent sending the input.
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
        #   The item type. Always `send_subagent_input_call`.
        #
        #   @return [Symbol, :send_subagent_input_call]
        required :type, const: :send_subagent_input_call

        # @!method initialize(id:, content:, recipient_agent_id:, sender_agent_id:, status:, turn_id:, type: :send_subagent_input_call)
        #   A request to send input to another agent.
        #
        #   @param id [String]
        #     The ID of the tool call item.
        #
        #   @param content [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
        #     The input sent to the receiving agent.
        #
        #   @param recipient_agent_id [String]
        #     The ID of the agent receiving the input.
        #
        #   @param sender_agent_id [String]
        #     The ID of the agent sending the input.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :send_subagent_input_call]
        #     The item type. Always `send_subagent_input_call`.
      end
    end
  end
end
