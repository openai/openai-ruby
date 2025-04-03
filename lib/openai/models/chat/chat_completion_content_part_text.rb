# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartText < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text content.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the content part.
        #
        #   @return [Symbol, :text]
        required :type, const: :text

        # @!parse
        #   # Learn about
        #   #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
        #   #
        #   # @param text [String]
        #   # @param type [Symbol, :text]
        #   #
        #   def initialize(text:, type: :text, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText
  end
end
