# frozen_string_literal: true

module OpenAI
  module Models
    class StaticFileChunkingStrategyObjectParam < OpenAI::Internal::Type::BaseModel
      # @!attribute static
      #
      #   @return [OpenAI::Models::StaticFileChunkingStrategy]
      required :static, -> { OpenAI::StaticFileChunkingStrategy }

      # @!attribute type
      #   Always `static`.
      #
      #   @return [Symbol, :static]
      required :type, const: :static

      # @!method initialize(static:, type: :static)
      #   Customize your own chunking strategy by setting chunk size and chunk overlap.
      #
      #   @param static [OpenAI::Models::StaticFileChunkingStrategy]
      #
      #   @param type [Symbol, :static] Always `static`.
    end
  end
end
