# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDeltaBlock < OpenAI::Internal::Type::BaseModel
          # @!attribute index
          #   The index of the content part in the message.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!attribute text
          #
          #   @return [OpenAI::Beta::Threads::TextDelta, nil]
          optional :text, -> { OpenAI::Beta::Threads::TextDelta }

          # @!method initialize(index:, text: nil, type: :text)
          #   The text content that is part of a message.
          #
          #   @param index [Integer] The index of the content part in the message.
          #
          #   @param text [OpenAI::Beta::Threads::TextDelta]
          #
          #   @param type [Symbol, :text] Always `text`.
        end
      end
    end
  end
end
