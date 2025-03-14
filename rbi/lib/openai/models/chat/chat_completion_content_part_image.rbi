# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartImage = T.type_alias { Chat::ChatCompletionContentPartImage }

    module Chat
      class ChatCompletionContentPartImage < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL) }
        def image_url
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL)
            .returns(OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL)
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
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          sig { params(url: String, detail: Symbol).returns(T.attached_class) }
          def self.new(url:, detail: nil)
          end

          sig { override.returns({url: String, detail: Symbol}) }
          def to_hash
          end

          # Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          class Detail < OpenAI::Enum
            abstract!

            AUTO = :auto
            LOW = :low
            HIGH = :high

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
