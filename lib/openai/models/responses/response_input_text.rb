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
        #   Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        #   breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        #   not rounded to a token block.
        #
        #   @return [OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint, -> { OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint }

        # @!method initialize(text:, prompt_cache_breakpoint: nil, type: :input_text)
        #   A text input to the model.
        #
        #   @param text [String]
        #     The text input to the model.
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint]
        #     Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        #     breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        #     not rounded to a token block.
        #
        #   @param type [Symbol, :input_text]
        #     The type of the input item. Always `input_text`.

        # @see OpenAI::Models::Responses::ResponseInputText#prompt_cache_breakpoint
        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          # @!attribute mode
          #   The breakpoint mode. Always `explicit`.
          #
          #   @return [Symbol, :explicit]
          required :mode, const: :explicit

          # @!attribute ttl
          #   The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl, nil]
          optional :ttl, enum: -> { OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl }

          # @!method initialize(ttl: nil, mode: :explicit)
          #   Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          #   breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          #   not rounded to a token block.
          #
          #   @param ttl [Symbol, OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl]
          #     The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          #   @param mode [Symbol, :explicit]
          #     The breakpoint mode. Always `explicit`.

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          #
          # @see OpenAI::Models::Responses::ResponseInputText::PromptCacheBreakpoint#ttl
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
  end
end
