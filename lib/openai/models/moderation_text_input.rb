# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
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
      #   @param text [String] A string of text to classify.
      #
      #   @param type [Symbol, :text] Always `text`.
    end
  end
end
