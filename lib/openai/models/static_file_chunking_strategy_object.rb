# frozen_string_literal: true

module OpenAI
  module Models
    class StaticFileChunkingStrategyObject < OpenAI::BaseModel
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
      #   # @param static [OpenAI::Models::StaticFileChunkingStrategy]
      #   # @param type [Symbol, :static]
      #   #
      #   def initialize(static:, type: :static, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
