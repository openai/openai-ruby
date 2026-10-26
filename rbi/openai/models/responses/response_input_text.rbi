# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseInputText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseInputText,
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
        sig { returns(T.nilable(OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint)) }
        attr_reader :prompt_cache_breakpoint

        sig {
          params(prompt_cache_breakpoint: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::OrHash).void
        }
        attr_writer :prompt_cache_breakpoint

        # A text input to the model.
        sig do
          params(

            text: String,

            prompt_cache_breakpoint: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
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
              prompt_cache_breakpoint: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint,
              OpenAI::Internal::AnyHash
            )
          end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          sig { returns(T.nilable(OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::OrSymbol)) }
          attr_reader :ttl

          sig { params(ttl: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::OrSymbol).void }
          attr_writer :ttl

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig do
            params(

              ttl: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::OrSymbol,

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
              {mode: Symbol, ttl: OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::OrSymbol}
            )
          end
          def to_hash
          end

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TTL_30M = T.let(:"30m", OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::TaggedSymbol)
            TTL_12H = T.let(:"12h", OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Responses::ResponseInputText::PromptCacheBreakpoint::Ttl::TaggedSymbol])
            }
            def self.values
            end
          end
        end

      end

    end

  end
end
