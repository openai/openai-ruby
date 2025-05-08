# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlock < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #
          #   @return [OpenAI::Beta::Threads::Text]
          required :text, -> { OpenAI::Beta::Threads::Text }

          # @!attribute type
          #   Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!method initialize(text:, type: :text)
          #   The text content that is part of a message.
          #
          #   @param text [OpenAI::Beta::Threads::Text]
          #
          #   @param type [Symbol, :text] Always `text`.
        end
      end
    end
  end
end
