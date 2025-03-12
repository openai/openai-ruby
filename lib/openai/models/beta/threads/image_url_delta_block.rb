# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDeltaBlock < OpenAI::BaseModel
          # @!attribute index
          #   The index of the content part in the message.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `image_url`.
          #
          #   @return [Symbol, :image_url]
          required :type, const: :image_url

          # @!attribute [r] image_url
          #
          #   @return [OpenAI::Models::Beta::Threads::ImageURLDelta, nil]
          optional :image_url, -> { OpenAI::Models::Beta::Threads::ImageURLDelta }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Threads::ImageURLDelta]
          #   attr_writer :image_url

          # @!parse
          #   # References an image URL in the content of a message.
          #   #
          #   # @param index [Integer]
          #   # @param image_url [OpenAI::Models::Beta::Threads::ImageURLDelta]
          #   # @param type [Symbol, :image_url]
          #   #
          #   def initialize(index:, image_url: nil, type: :image_url, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
