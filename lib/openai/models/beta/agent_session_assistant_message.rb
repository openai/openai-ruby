# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionAssistantMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the message.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The content of the message.
        #
        #   @return [Array<OpenAI::Models::Beta::OutputText>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::OutputText] }

        # @!attribute phase
        #   The phase of an assistant message.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSessionAssistantMessage::Phase, nil]
        required :phase, enum: -> { OpenAI::Beta::AgentSessionAssistantMessage::Phase }, nil?: true

        # @!attribute role
        #   The role of the message author. Always `assistant`.
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute status
        #   The status of the message.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus]
        required :status, enum: -> { OpenAI::Beta::AgentOutputItemStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!method initialize(id:, content:, phase:, status:, turn_id:, role: :assistant, type: :message)
        #   An assistant message produced by the agent.
        #
        #   @param id [String]
        #     The ID of the message.
        #
        #   @param content [Array<OpenAI::Models::Beta::OutputText>]
        #     The content of the message.
        #
        #   @param phase [Symbol, OpenAI::Models::Beta::AgentSessionAssistantMessage::Phase, nil]
        #     The phase of an assistant message.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus]
        #     The status of the message.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param role [Symbol, :assistant]
        #     The role of the message author. Always `assistant`.
        #
        #   @param type [Symbol, :message]
        #     The item type. Always `message`.

        # The phase of an assistant message.
        #
        # @see OpenAI::Models::Beta::AgentSessionAssistantMessage#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          # Commentary produced while the agent works.
          COMMENTARY = :commentary

          # The agent's final answer.
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
