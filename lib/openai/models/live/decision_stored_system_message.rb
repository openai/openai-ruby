# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionStoredSystemMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionInputText>]
        required :content, union: -> { OpenAI::Live::DecisionStoredSystemMessage::Content }

        # @!attribute role
        #
        #   @return [Symbol, :system]
        required :role, const: :system

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionStoredSystemMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionStoredSystemMessage::Type }

        # @!method initialize(id:, content:, type: nil, role: :system)
        #   @param id [String]
        #
        #   @param content [String, Array<OpenAI::Models::Live::DecisionInputText>]
        #     The text input to the model.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionStoredSystemMessage::Type]
        #
        #   @param role [Symbol, :system]

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionStoredSystemMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionStoredSystemMessage::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Live::DecisionInputText }]
        end

        # @see OpenAI::Models::Live::DecisionStoredSystemMessage#type
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
