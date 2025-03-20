# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartImage < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL) }
        def image_url
        end

        sig do
          params(_: T.any(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, OpenAI::Util::AnyHash))
        end
        def image_url=(_)
        end

        # The type of the content part.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(image_url: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(image_url:, type: :image_url)
        end

        sig do
          override.returns({image_url: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, type: Symbol})
        end
        def to_hash
        end

        class ImageURL < OpenAI::BaseModel
          # Either a URL of the image or the base64 encoded image data.
          sig { returns(String) }
          def url
          end

          sig { params(_: String).returns(String) }
          def url=(_)
          end

          # Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol)) }
          def detail
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol)
              .returns(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol)
          end
          def detail=(_)
          end

          sig do
            params(
              url: String,
              detail: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(url:, detail: nil)
          end

          sig do
            override
              .returns(
                {url: String, detail: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol}
              )
          end
          def to_hash
          end

          # Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          module Detail
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)

            class << self
              sig do
                override
                  .returns(T::Array[OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol])
              end
              def values
              end
            end
          end
        end
      end
    end

    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage
  end
end
