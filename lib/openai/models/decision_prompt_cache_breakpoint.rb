# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionPromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
      # @!attribute mode
      #   The breakpoint mode. Always `explicit`.
      #
      #   @return [Symbol, :explicit]
      required :mode, const: :explicit

      # @!method initialize(mode: :explicit)
      #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      #   token block.
      #
      #   @param mode [Symbol, :explicit]
      #     The breakpoint mode. Always `explicit`.
    end
  end
end
