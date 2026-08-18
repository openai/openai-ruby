# typed: strong

module OpenAI
  module Models
    BetaResponseInputText = Beta::BetaResponseInputText

    module Beta
      class BetaResponseInputText < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInputText,
              OpenAI::Internal::AnyHash
            )
          end

        # The text input to the model.
        sig { returns(String) }
        attr_accessor :text

        # The type of the input item. Always `input_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseInputText::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              OpenAI::Beta::BetaResponseInputText::PromptCacheBreakpoint::OrHash
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # A text input to the model.
        sig do
          params(
            text: String,
            prompt_cache_breakpoint:
              OpenAI::Beta::BetaResponseInputText::PromptCacheBreakpoint::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text input to the model.
          text:,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,
          # The type of the input item. Always `input_text`.
          type: :input_text
        )
        end

        sig do
          override.returns(
            {
              text: String,
              type: Symbol,
              prompt_cache_breakpoint:
                OpenAI::Beta::BetaResponseInputText::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseInputText::PromptCacheBreakpoint,
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
