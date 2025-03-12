# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::BaseModel
          # @!attribute [r] detail
          #   Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #     to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageURLDelta::Detail }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail]
          #   attr_writer :detail

          # @!attribute [r] url
          #   The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
          #     webp.
          #
          #   @return [String, nil]
          optional :url, String

          # @!parse
          #   # @return [String]
          #   attr_writer :url

          # @!parse
          #   # @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail]
          #   # @param url [String]
          #   #
          #   def initialize(detail: nil, url: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # @abstract
          #
          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          class Detail < OpenAI::Enum
            AUTO = :auto
            LOW = :low
            HIGH = :high

            finalize!
          end
        end
      end
    end
  end
end
