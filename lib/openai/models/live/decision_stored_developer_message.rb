# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionStoredDeveloperMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionInputText>]
        required :content, union: -> { OpenAI::Live::DecisionStoredDeveloperMessage::Content }

        # @!attribute role
        #
        #   @return [Symbol, :developer]
        required :role, const: :developer

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionStoredDeveloperMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionStoredDeveloperMessage::Type }

        # @!method initialize(id:, content:, type: nil, role: :developer)
        #   @param id [String]
        #
        #   @param content [String, Array<OpenAI::Models::Live::DecisionInputText>]
        #     The text input to the model.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionStoredDeveloperMessage::Type]
        #
        #   @param role [Symbol, :developer]

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionStoredDeveloperMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionStoredDeveloperMessage::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Live::DecisionInputText }]
        end

        # @see OpenAI::Models::Live::DecisionStoredDeveloperMessage#type
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
