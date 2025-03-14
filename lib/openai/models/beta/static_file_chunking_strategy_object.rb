# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class StaticFileChunkingStrategyObject < OpenAI::BaseModel
        # @!attribute static
        #
        #   @return [OpenAI::Models::Beta::StaticFileChunkingStrategy]
        required :static, -> { OpenAI::Models::Beta::StaticFileChunkingStrategy }

        # @!attribute type
        #   Always `static`.
        #
        #   @return [Symbol, :static]
        required :type, const: :static

        # @!parse
        #   # @param static [OpenAI::Models::Beta::StaticFileChunkingStrategy]
        #   # @param type [Symbol, :static]
        #   #
        #   def initialize(static:, type: :static, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
