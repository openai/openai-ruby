# frozen_string_literal: true

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::BaseModel
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

      # @!parse
      #   # An object describing an image to classify.
      #   #
      #   # @param image_url [OpenAI::Models::ModerationImageURLInput::ImageURL]
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

        # @!parse
        #   # Contains either an image URL or a data URL for a base64 encoded image.
        #   #
        #   # @param url [String]
        #   #
        #   def initialize(url:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
