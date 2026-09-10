# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of this item, or null for legacy user messages whose ID was not recorded.
        #
        #   @return [String, nil]
        required :id, String, nil?: true

        # @!attribute content
        #   The content of the message. User messages contain input text or images;
        #   assistant messages contain output text.
        #
        #   @return [Array<OpenAI::Models::Beta::AgentSessionMessageContent::InputText, OpenAI::Models::Beta::AgentSessionMessageContent::InputImage, OpenAI::Models::Beta::AgentSessionMessageContent::OutputText>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSessionMessageContent] }

        # @!attribute phase
        #   The phase of an assistant message.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSessionMessage::Phase, nil]
        required :phase, enum: -> { OpenAI::Beta::AgentSessionMessage::Phase }, nil?: true

        # @!attribute role
        #   The role of the message author.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSessionMessage::Role]
        required :role, enum: -> { OpenAI::Beta::AgentSessionMessage::Role }

        # @!attribute status
        #   The status of the message. User messages are always `completed`.
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

        # @!method initialize(id:, content:, phase:, role:, status:, turn_id:, type: :message)
        #   A user or assistant message recorded in a session.
        #
        #   @param id [String, nil]
        #     The ID of this item, or null for legacy user messages whose ID was not recorded.
        #
        #   @param content [Array<OpenAI::Models::Beta::AgentSessionMessageContent::InputText, OpenAI::Models::Beta::AgentSessionMessageContent::InputImage, OpenAI::Models::Beta::AgentSessionMessageContent::OutputText>]
        #     The content of the message. User messages contain input text or images;
        #     assistant messages contain output text.
        #
        #   @param phase [Symbol, OpenAI::Models::Beta::AgentSessionMessage::Phase, nil]
        #     The phase of an assistant message.
        #
        #   @param role [Symbol, OpenAI::Models::Beta::AgentSessionMessage::Role]
        #     The role of the message author.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus]
        #     The status of the message. User messages are always `completed`.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :message]
        #     The item type. Always `message`.

        # The phase of an assistant message.
        #
        # @see OpenAI::Models::Beta::AgentSessionMessage#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          # Commentary produced while the agent works.
          COMMENTARY = :commentary

          # The agent's final answer.
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The role of the message author.
        #
        # @see OpenAI::Models::Beta::AgentSessionMessage#role
        module Role
          extend OpenAI::Internal::Type::Enum

          USER = :user
          ASSISTANT = :assistant

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
