# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputText < OpenAI::Internal::Type::BaseModel
      # @!attribute text
      #
      #   @return [String]
      required :text, String

      # @!attribute type
      #
      #   @return [Symbol, :input_text]
      required :type, const: :input_text

      # @!attribute prompt_cache_breakpoint
      #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      #   token block.
      #
      #   @return [OpenAI::Models::DecisionPromptCacheBreakpoint, nil]
      optional :prompt_cache_breakpoint, -> { OpenAI::DecisionPromptCacheBreakpoint }, nil?: true

      # @!method initialize(text:, prompt_cache_breakpoint: nil, type: :input_text)
      #   @param text [String]
      #
      #   @param prompt_cache_breakpoint [OpenAI::Models::DecisionPromptCacheBreakpoint, nil]
      #     Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      #     from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      #     token block.
      #
      #   @param type [Symbol, :input_text]
    end
  end
end
