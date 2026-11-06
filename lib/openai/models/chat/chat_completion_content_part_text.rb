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
        #   Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        #   breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        #   not rounded to a token block.
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
        #     Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        #     breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        #     not rounded to a token block.
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

          # @!attribute ttl
          #   The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl, nil]
          optional :ttl, enum: -> { OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl }

          # @!method initialize(ttl: nil, mode: :explicit)
          #   Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          #   breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          #   not rounded to a token block.
          #
          #   @param ttl [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl]
          #     The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          #   @param mode [Symbol, :explicit]
          #     The breakpoint mode. Always `explicit`.

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          # @see OpenAI::Models::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint#ttl
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TTL_30M = :"30m"
            TTL_12H = :"12h"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText
  end
end
