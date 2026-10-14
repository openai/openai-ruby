# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartText < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text content.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the content part.
        #
        #   @return [Symbol, :text]
        required :type, const: :text

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint, nil]
        optional(
          :prompt_cache_breakpoint,
          -> { OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint }
        )

        # @!method initialize(text:, prompt_cache_breakpoint: nil, type: :text)
        #   Learn about [text inputs](https://developers.openai.com/api/docs/guides/text).
        #
        #   @param text [String]
        #     The text content.
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint]
        #     Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #     from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #     token block.
        #
        #   @param type [Symbol, :text]
        #     The type of the content part.

        # @see OpenAI::Models::Chat::ChatCompletionContentPartText#prompt_cache_breakpoint
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
          #   @param mode [Symbol, :explicit]
          #     The breakpoint mode. Always `explicit`.
        end
      end
    end

    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText
  end
end
