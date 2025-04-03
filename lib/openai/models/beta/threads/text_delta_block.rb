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

          # @!attribute [r] text
          #
          #   @return [OpenAI::Models::Beta::Threads::TextDelta, nil]
          optional :text, -> { OpenAI::Models::Beta::Threads::TextDelta }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Threads::TextDelta]
          #   attr_writer :text

          # @!parse
          #   # The text content that is part of a message.
          #   #
          #   # @param index [Integer]
          #   # @param text [OpenAI::Models::Beta::Threads::TextDelta]
          #   # @param type [Symbol, :text]
          #   #
          #   def initialize(index:, text: nil, type: :text, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
