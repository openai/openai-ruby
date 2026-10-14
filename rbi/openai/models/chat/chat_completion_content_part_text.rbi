# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText

    module Chat
      class ChatCompletionContentPartText < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
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

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::OrHash
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # Learn about
        # [text inputs](https://platform.openai.com/docs/guides/text-generation).
        sig do
          params(
            text: String,
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text content.
          text:,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
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
              prompt_cache_breakpoint:
                OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPartText::PromptCacheBreakpoint,
                OpenAI::Internal::AnyHash
              )
            end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig { params(mode: Symbol).returns(T.attached_class) }
          def self.new(
            # The breakpoint mode. Always `explicit`.
            mode: :explicit
          )
          end

          sig { override.returns({ mode: Symbol }) }
          def to_hash
          end
        end
      end
    end
  end
end
