# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionSystemMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionInputText>]
        required :content, union: -> { OpenAI::Live::DecisionSystemMessage::Content }

        # @!attribute role
        #
        #   @return [Symbol, :system]
        required :role, const: :system

        # @!attribute id
        #   The unique ID of this message item.
        #
        #   @return [String, nil]
        optional :id, String, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionSystemMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionSystemMessage::Type }

        # @!method initialize(content:, id: nil, type: nil, role: :system)
        #   @param content [String, Array<OpenAI::Models::Live::DecisionInputText>]
        #     The text input to the model.
        #
        #   @param id [String, nil]
        #     The unique ID of this message item.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionSystemMessage::Type]
        #
        #   @param role [Symbol, :system]

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionSystemMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionSystemMessage::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Live::DecisionInputText }]
        end

        # @see OpenAI::Models::Live::DecisionSystemMessage#type
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
