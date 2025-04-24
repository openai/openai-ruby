# frozen_string_literal: true

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::Internal::Type::BaseModel
      # @!attribute image_url
      #   Contains either an image URL or a data URL for a base64 encoded image.
      #
      #   @return [OpenAI::Models::ModerationImageURLInput::ImageURL]
      required :image_url, -> { OpenAI::Models::ModerationImageURLInput::ImageURL }

      # @!attribute type
      #   Always `image_url`.
      #
      #   @return [Symbol, :image_url]
      required :type, const: :image_url

      # @!method initialize(image_url:, type: :image_url)
      #   An object describing an image to classify.
      #
      #   @param image_url [OpenAI::Models::ModerationImageURLInput::ImageURL] Contains either an image URL or a data URL for a base64 encoded image.
      #
      #   @param type [Symbol, :image_url] Always `image_url`.

      # @see OpenAI::Models::ModerationImageURLInput#image_url
      class ImageURL < OpenAI::Internal::Type::BaseModel
        # @!attribute url
        #   Either a URL of the image or the base64 encoded image data.
        #
        #   @return [String]
        required :url, String

        # @!method initialize(url:)
        #   Contains either an image URL or a data URL for a base64 encoded image.
        #
        #   @param url [String] Either a URL of the image or the base64 encoded image data.
      end
    end
  end
end
