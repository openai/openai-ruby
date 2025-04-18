# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::Internal::Type::BaseModel
          # @!attribute url
          #   The external URL of the image, must be a supported image types: jpeg, jpg, png,
          #   gif, webp.
          #
          #   @return [String]
          required :url, String

          # @!attribute detail
          #   Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageURL::Detail }

          # @!method initialize(url:, detail: nil)
          #   @param url [String]
          #   @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail]

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`. Default value is `auto`
          #
          # @see OpenAI::Models::Beta::Threads::ImageURL#detail
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
