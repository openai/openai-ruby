# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute detail
          #   Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageURLDelta::Detail }

          # @!attribute url
          #   The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
          #   webp.
          #
          #   @return [String, nil]
          optional :url, String

          # @!method initialize(detail: nil, url: nil)
          #   @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail]
          #   @param url [String]

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`.
          #
          # @see OpenAI::Models::Beta::Threads::ImageURLDelta#detail
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
  end
end
