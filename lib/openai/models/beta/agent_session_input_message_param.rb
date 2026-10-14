# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionInputMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The content of the message.
        #
        #   @return [Array<OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::InputContentParam] }

        # @!attribute role
        #   The role of the message author. Always `user`.
        #
        #   @return [Symbol, :user]
        required :role, const: :user

        # @!attribute type
        #   The type of the input item. Always `message`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSessionInputMessageParam::Type, nil]
        optional :type, enum: -> { OpenAI::Beta::AgentSessionInputMessageParam::Type }

        # @!method initialize(content:, type: nil, role: :user)
        #   A user message submitted to a session.
        #
        #   @param content [Array<OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage>]
        #     The content of the message.
        #
        #   @param type [Symbol, OpenAI::Models::Beta::AgentSessionInputMessageParam::Type]
        #     The type of the input item. Always `message`.
        #
        #   @param role [Symbol, :user]
        #     The role of the message author. Always `user`.

        # The type of the input item. Always `message`.
        #
        # @see OpenAI::Models::Beta::AgentSessionInputMessageParam#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
