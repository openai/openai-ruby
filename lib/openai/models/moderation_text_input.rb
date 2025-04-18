# frozen_string_literal: true

module OpenAI
  module Models
    class ModerationTextInput < OpenAI::Internal::Type::BaseModel
      # @!attribute text
      #   A string of text to classify.
      #
      #   @return [String]
      required :text, String

      # @!attribute type
      #   Always `text`.
      #
      #   @return [Symbol, :text]
      required :type, const: :text

      # @!method initialize(text:, type: :text)
      #   An object describing text to classify.
      #
      #   @param text [String]
      #   @param type [Symbol, :text]
    end
  end
end
