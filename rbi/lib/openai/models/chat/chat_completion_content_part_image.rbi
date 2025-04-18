# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartImage < OpenAI::Internal::Type::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL) }
        attr_reader :image_url

        sig do
          params(
            image_url: T.any(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :image_url

        # The type of the content part.
        sig { returns(Symbol) }
        attr_accessor :type

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(
            image_url: T.any(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, OpenAI::Internal::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(image_url:, type: :image_url); end

        sig do
          override.returns({image_url: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL, type: Symbol})
        end
        def to_hash; end

        class ImageURL < OpenAI::Internal::Type::BaseModel
          # Either a URL of the image or the base64 encoded image data.
          sig { returns(String) }
          attr_accessor :url

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol)) }
          attr_reader :detail

          sig { params(detail: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol).void }
          attr_writer :detail

          sig do
            params(
              url: String,
              detail: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(url:, detail: nil); end

          sig do
            override
              .returns(
                {url: String, detail: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::OrSymbol}
              )
          end
          def to_hash; end

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(:auto, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol)

            sig do
              override
                .returns(T::Array[OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail::TaggedSymbol])
            end
            def self.values; end
          end
        end
      end
    end

    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage
  end
end
