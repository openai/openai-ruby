# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartImage < OpenAI::BaseModel
        # @!attribute image_url
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL]
        required :image_url, -> { OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL }

        # @!attribute type
        #   The type of the content part.
        #
        #   @return [Symbol, :image_url]
        required :type, const: :image_url

        # @!parse
        #   # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        #   #
        #   # @param image_url [OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL]
        #   # @param type [Symbol, :image_url]
        #   #
        #   def initialize(image_url:, type: :image_url, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class ImageURL < OpenAI::BaseModel
          # @!attribute url
          #   Either a URL of the image or the base64 encoded image data.
          #
          #   @return [String]
          required :url, String

          # @!attribute [r] detail
          #   Specifies the detail level of the image. Learn more in the
          #     [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail]
          #   attr_writer :detail

          # @!parse
          #   # @param url [String]
          #   # @param detail [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail]
          #   #
          #   def initialize(url:, detail: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          module Detail
            extend OpenAI::Enum

            AUTO = :auto
            LOW = :low
            HIGH = :high

            finalize!

            class << self
              # @!parse
              #   # @return [Array<Symbol>]
              #   def values; end
            end
          end
        end
      end
    end

    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage
  end
end
