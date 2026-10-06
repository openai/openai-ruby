# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputMessage < OpenAI::Internal::Type::BaseModel
      # @!attribute content
      #   Text evidence or an ordered list of text and inline image parts.
      #
      #   @return [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
      required :content, union: -> { OpenAI::DecisionInputMessage::Content }

      # @!attribute role
      #
      #   @return [Symbol, :user]
      required :role, const: :user

      # @!attribute type
      #
      #   @return [Symbol, OpenAI::Models::DecisionInputMessage::Type, nil]
      optional :type, enum: -> { OpenAI::DecisionInputMessage::Type }

      # @!method initialize(content:, type: nil, role: :user)
      #   A user message containing text or inline images.
      #
      #   @param content [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
      #     Text evidence or an ordered list of text and inline image parts.
      #
      #   @param type [Symbol, OpenAI::Models::DecisionInputMessage::Type]
      #
      #   @param role [Symbol, :user]

      # Text evidence or an ordered list of text and inline image parts.
      #
      # @see OpenAI::Models::DecisionInputMessage#content
      module Content
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::DecisionInputMessage::Content::DecisionInputPartArray }

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>)]

        # @type [OpenAI::Internal::Type::Converter]
        DecisionInputPartArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::DecisionInputPart }]
      end

      # @see OpenAI::Models::DecisionInputMessage#type
      module Type
        extend OpenAI::Internal::Type::Enum

        MESSAGE = :message

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
