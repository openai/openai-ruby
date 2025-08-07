# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatTextGrammar < OpenAI::Internal::Type::BaseModel
      # @!attribute grammar
      #   The custom grammar for the model to follow.
      #
      #   @return [String]
      required :grammar, String

      # @!attribute type
      #   The type of response format being defined. Always `grammar`.
      #
      #   @return [Symbol, :grammar]
      required :type, const: :grammar

      # @!method initialize(grammar:, type: :grammar)
      #   A custom grammar for the model to follow when generating text. Learn more in the
      #   [custom grammars guide](https://platform.openai.com/docs/guides/custom-grammars).
      #
      #   @param grammar [String] The custom grammar for the model to follow.
      #
      #   @param type [Symbol, :grammar] The type of response format being defined. Always `grammar`.
    end
  end
end
