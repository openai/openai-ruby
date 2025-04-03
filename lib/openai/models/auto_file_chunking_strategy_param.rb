# frozen_string_literal: true

module OpenAI
  module Models
    class AutoFileChunkingStrategyParam < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   Always `auto`.
      #
      #   @return [Symbol, :auto]
      required :type, const: :auto

      # @!parse
      #   # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
      #   #   `800` and `chunk_overlap_tokens` of `400`.
      #   #
      #   # @param type [Symbol, :auto]
      #   #
      #   def initialize(type: :auto, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
