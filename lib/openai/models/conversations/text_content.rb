# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class TextContent < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #
        #   @return [Symbol, :text]
        required :type, const: :text

        # @!method initialize(text:, type: :text)
        #   A text content.
        #
        #   @param text [String]
        #   @param type [Symbol, :text]
      end
    end
  end
end
