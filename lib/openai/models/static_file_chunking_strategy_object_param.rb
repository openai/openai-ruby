# frozen_string_literal: true

module OpenAI
  module Models
    class StaticFileChunkingStrategyObjectParam < OpenAI::Internal::Type::BaseModel
      # @!attribute static
      #
      #   @return [OpenAI::Models::StaticFileChunkingStrategy]
      required :static, -> { OpenAI::Models::StaticFileChunkingStrategy }

      # @!attribute type
      #   Always `static`.
      #
      #   @return [Symbol, :static]
      required :type, const: :static

      # @!parse
      #   # Customize your own chunking strategy by setting chunk size and chunk overlap.
      #   #
      #   # @param static [OpenAI::Models::StaticFileChunkingStrategy]
      #   # @param type [Symbol, :static]
      #   #
      #   def initialize(static:, type: :static, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
