# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputText < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text input to the model.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the input item. Always `input_text`.
        #
        #   @return [Symbol, :input_text]
        required :type, const: :input_text

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint, -> { OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint }

        # @!method initialize(text:, prompt_cache_breakpoint: nil, type: :input_text)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInputText} for more details.
        #
        #   A text input to the model.
        #
        #   @param text [String] The text input to the model.
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint] Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #
        #   @param type [Symbol, :input_text] The type of the input item. Always `input_text`.

        # @see OpenAI::Models::Responses::ResponseInputText#prompt_cache_breakpoint
        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
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
          #   @param mode [Symbol, :explicit] The breakpoint mode. Always `explicit`.
        end
      end
    end
  end
end
