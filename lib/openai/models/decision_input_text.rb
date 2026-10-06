# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputText < OpenAI::Internal::Type::BaseModel
      # @!attribute text
      #
      #   @return [String]
      required :text, String

      # @!attribute type
      #
      #   @return [Symbol, :input_text]
      required :type, const: :input_text

      # @!method initialize(text:, type: :input_text)
      #   @param text [String]
      #   @param type [Symbol, :input_text]
    end
  end
end
