# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlock < OpenAI::BaseModel
          # @!attribute text
          #
          #   @return [OpenAI::Models::Beta::Threads::Text]
          required :text, -> { OpenAI::Models::Beta::Threads::Text }

          # @!attribute type
          #   Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!parse
          #   # The text content that is part of a message.
          #   #
          #   # @param text [OpenAI::Models::Beta::Threads::Text]
          #   # @param type [Symbol, :text]
          #   #
          #   def initialize(text:, type: :text, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
