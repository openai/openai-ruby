# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartImage < OpenAI::Internal::Type::BaseModel
        # @!attribute image_url
        #
        #   @return [OpenAI::Chat::ChatCompletionContentPartImage::ImageURL]
        required :image_url, -> { OpenAI::Chat::ChatCompletionContentPartImage::ImageURL }

        # @!attribute type
        #   The type of the content part.
        #
        #   @return [Symbol, :image_url]
        required :type, const: :image_url

        # @!method initialize(image_url:, type: :image_url)
        #   Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        #
        #   @param image_url [OpenAI::Chat::ChatCompletionContentPartImage::ImageURL]
        #
        #   @param type [Symbol, :image_url] The type of the content part.

        # @see OpenAI::Chat::ChatCompletionContentPartImage#image_url
        class ImageURL < OpenAI::Internal::Type::BaseModel
          # @!attribute url
          #   Either a URL of the image or the base64 encoded image data.
          #
          #   @return [String]
          required :url, String

          # @!attribute detail
          #   Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          #
          #   @return [Symbol, OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail, nil]
          optional :detail, enum: -> { OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail }

          # @!method initialize(url:, detail: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Chat::ChatCompletionContentPartImage::ImageURL} for more details.
          #
          #   @param url [String] Either a URL of the image or the base64 encoded image data.
          #
          #   @param detail [Symbol, OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail] Specifies the detail level of the image. Learn more in the [Vision guide](https:

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          #
          # @see OpenAI::Chat::ChatCompletionContentPartImage::ImageURL#detail
          module Detail
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            LOW = :low
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage
  end
end
