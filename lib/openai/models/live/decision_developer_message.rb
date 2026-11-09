# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionDeveloperMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionInputText>]
        required :content, union: -> { OpenAI::Live::DecisionDeveloperMessage::Content }

        # @!attribute role
        #
        #   @return [Symbol, :developer]
        required :role, const: :developer

        # @!attribute id
        #   The unique ID of this message item.
        #
        #   @return [String, nil]
        optional :id, String, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionDeveloperMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionDeveloperMessage::Type }

        # @!method initialize(content:, id: nil, type: nil, role: :developer)
        #   @param content [String, Array<OpenAI::Models::Live::DecisionInputText>]
        #     The text input to the model.
        #
        #   @param id [String, nil]
        #     The unique ID of this message item.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionDeveloperMessage::Type]
        #
        #   @param role [Symbol, :developer]

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionDeveloperMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionDeveloperMessage::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Live::DecisionInputText }]
        end

        # @see OpenAI::Models::Live::DecisionDeveloperMessage#type
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
