# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlockParam < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   Text content to be sent to the model
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!method initialize(text:, type: :text)
          #   The text content that is part of a message.
          #
          #   @param text [String] Text content to be sent to the model
          #
          #   @param type [Symbol, :text] Always `text`.
        end
      end
    end
  end
end
