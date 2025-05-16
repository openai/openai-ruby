# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLContentBlock < OpenAI::Internal::Type::BaseModel
          # @!attribute image_url
          #
          #   @return [OpenAI::Beta::Threads::ImageURL]
          required :image_url, -> { OpenAI::Beta::Threads::ImageURL }

          # @!attribute type
          #   The type of the content part.
          #
          #   @return [Symbol, :image_url]
          required :type, const: :image_url

          # @!method initialize(image_url:, type: :image_url)
          #   References an image URL in the content of a message.
          #
          #   @param image_url [OpenAI::Beta::Threads::ImageURL]
          #
          #   @param type [Symbol, :image_url] The type of the content part.
        end
      end
    end
  end
end
