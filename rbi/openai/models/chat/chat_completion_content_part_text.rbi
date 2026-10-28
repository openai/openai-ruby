# typed: strong

module OpenAI
  module Models

    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText

    module Chat

      class ChatCompletionContentPartText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Chat::ChatCompletionContentPartText,
            OpenAI::Internal::AnyHash
          )
        end

        # The text content.
        sig { returns(String) }
        attr_accessor :text

        # The type of the content part.
        sig { returns(Symbol) }
        attr_accessor :type

        # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        # not rounded to a token block.
        sig { returns(T.nilable(OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint)) }
        attr_reader :prompt_cache_breakpoint

        sig {
          params(prompt_cache_breakpoint: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::OrHash)
            .void
        }
        attr_writer :prompt_cache_breakpoint

        # Learn about [text inputs](https://developers.openai.com/api/docs/guides/text).
        sig do
          params(

            text: String,

            prompt_cache_breakpoint: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The text content.
          text:,

          # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          # not rounded to a token block.
          prompt_cache_breakpoint: nil,

          # The type of the content part.

          type: :text
        )
        end

        sig do
          override.returns(
            {
              text: String,
              type: Symbol,
              prompt_cache_breakpoint: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint,
              OpenAI::Internal::AnyHash
            )
          end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          sig { returns(T.nilable(OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::OrSymbol)) }
          attr_reader :ttl

          sig { params(ttl: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::OrSymbol).void }
          attr_writer :ttl

          # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          # not rounded to a token block.
          sig do
            params(

              ttl: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::OrSymbol,

              mode: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
            ttl: nil,

            # The breakpoint mode. Always `explicit`.

            mode: :explicit
          )
          end

          sig do
            override.returns(
              {mode: Symbol, ttl: OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::OrSymbol}
            )
          end
          def to_hash
          end

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TTL_30M = T.let(
              :"30m",
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::TaggedSymbol
            )
            TTL_12H = T.let(
              :"12h",
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::Ttl::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

      end

    end

  end
end
