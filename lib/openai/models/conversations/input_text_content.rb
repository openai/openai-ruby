# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class InputTextContent < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text input to the model.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the input item. Always `input_text`.
        #
        #   @return [Symbol, :input_text]
        required :type, const: :input_text

        # @!method initialize(text:, type: :input_text)
        #   @param text [String] The text input to the model.
        #
        #   @param type [Symbol, :input_text] The type of the input item. Always `input_text`.
      end
    end
  end
end
