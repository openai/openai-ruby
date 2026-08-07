# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    class StaticFileChunkingStrategyObject < OpenAI::Internal::Type::BaseModel
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
      #   @param static [OpenAI::Models::StaticFileChunkingStrategy]
      #
      #   @param type [Symbol, :static] Always `static`.
    end
  end
end
