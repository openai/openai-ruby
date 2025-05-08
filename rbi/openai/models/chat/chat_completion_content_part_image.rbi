# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage

    module Chat
      class ChatCompletionContentPartImage < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(
            image_url:
              OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          image_url:,
          # The type of the content part.
          type: :image_url
        )
        end

        sig do
          override.returns(
            {
              image_url: OpenAI::Chat::ChatCompletionContentPartImage::ImageURL,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class ImageURL < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
      end
    end
  end
end
