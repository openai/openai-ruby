# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::BaseModel
          # @!attribute url
          #   The external URL of the image, must be a supported image types: jpeg, jpg, png,
          #     gif, webp.
          #
          #   @return [String]
          required :url, String

          # @!attribute [r] detail
          #   Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #     to high resolution using `high`. Default value is `auto`
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageURL::Detail }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail]
          #   attr_writer :detail

          # @!parse
          #   # @param url [String]
          #   # @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail]
          #   #
          #   def initialize(url:, detail: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # @abstract
          #
          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
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
