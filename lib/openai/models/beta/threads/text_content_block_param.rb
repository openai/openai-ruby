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

          # @!parse
          #   # The text content that is part of a message.
          #   #
          #   # @param text [String]
          #   # @param type [Symbol, :text]
          #   #
          #   def initialize(text:, type: :text, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
