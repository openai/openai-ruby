# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage

    module Chat
      class ChatCompletionContentPartImage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionContentPartImage,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(OpenAI::Chat::ChatCompletionContentPartImage::ImageURL) }
        attr_reader :image_url

        sig do
          params(
            image_url:
              OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::OrHash
          ).void
        end
        attr_writer :image_url

        # The type of the content part.
        sig { returns(Symbol) }
        attr_accessor :type

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint::OrHash
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(
            image_url:
              OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::OrHash,
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          image_url:,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,
          # The type of the content part.
          type: :image_url
        )
        end

        sig do
          override.returns(
            {
              image_url: OpenAI::Chat::ChatCompletionContentPartImage::ImageURL,
              type: Symbol,
              prompt_cache_breakpoint:
                OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        class ImageURL < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL,
                OpenAI::Internal::AnyHash
              )
            end

          # Either a URL of the image or the base64 encoded image data.
          sig { returns(String) }
          attr_accessor :url

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          sig do
            returns(
              T.nilable(
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
              )
            )
          end
          attr_reader :detail

          sig do
            params(
              detail:
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
            ).void
          end
          attr_writer :detail

          sig do
            params(
              url: String,
              detail:
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Either a URL of the image or the base64 encoded image data.
            url:,
            # Specifies the detail level of the image. Learn more in the
            # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
            detail: nil
          )
          end

          sig do
            override.returns(
              {
                url: String,
                detail:
                  OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint,
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
