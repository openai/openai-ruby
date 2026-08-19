# typed: strong

module OpenAI
  module Models

    BetaResponseInputImage = Beta::BetaResponseInputImage

    module Beta

      class BetaResponseInputImage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseInputImage,
            OpenAI::Internal::AnyHash
          )
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`,
        # `auto`, or `original`. Defaults to `auto`.
        sig { returns(OpenAI::Beta::BetaResponseInputImage::Detail::OrSymbol) }
        attr_accessor :detail

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the image to be sent to the model. A fully qualified URL or base64
        # encoded image in a data URL.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseInputImage::PromptCacheBreakpoint)) }
        attr_reader :prompt_cache_breakpoint

        sig {
          params(prompt_cache_breakpoint: OpenAI::Beta::BetaResponseInputImage::PromptCacheBreakpoint::OrHash).void
        }
        attr_writer :prompt_cache_breakpoint

        # An image input to the model. Learn about
        # [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(

            detail: OpenAI::Beta::BetaResponseInputImage::Detail::OrSymbol,

            file_id: T.nilable(String),

            image_url: T.nilable(String),

            prompt_cache_breakpoint: OpenAI::Beta::BetaResponseInputImage::PromptCacheBreakpoint::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The detail level of the image to be sent to the model. One of `high`, `low`,
          # `auto`, or `original`. Defaults to `auto`.
          detail:,

          # The ID of the file to be sent to the model.
          file_id: nil,

          # The URL of the image to be sent to the model. A fully qualified URL or base64
          # encoded image in a data URL.
          image_url: nil,

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,

          # The type of the input item. Always `input_image`.

          type: :input_image
        )
        end

        sig do
          override.returns(
            {
              detail: OpenAI::Beta::BetaResponseInputImage::Detail::OrSymbol,
              type: Symbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              prompt_cache_breakpoint: OpenAI::Beta::BetaResponseInputImage::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`,
        # `auto`, or `original`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::BetaResponseInputImage::Detail) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW = T.let(:low, OpenAI::Beta::BetaResponseInputImage::Detail::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Beta::BetaResponseInputImage::Detail::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Beta::BetaResponseInputImage::Detail::TaggedSymbol)
          ORIGINAL = T.let(:original, OpenAI::Beta::BetaResponseInputImage::Detail::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::BetaResponseInputImage::Detail::TaggedSymbol]) }
          def self.values
          end
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInputImage::PromptCacheBreakpoint,
              OpenAI::Internal::AnyHash
            )
          end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig do
            params(

              mode: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The breakpoint mode. Always `explicit`.

            mode: :explicit
          )
          end

          sig do
            override.returns(
              {mode: Symbol}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
