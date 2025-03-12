# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDeltaBlock < OpenAI::BaseModel
          # @!attribute index
          #   The index of the content part in the message.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `image_file`.
          #
          #   @return [Symbol, :image_file]
          required :type, const: :image_file

          # @!attribute [r] image_file
          #
          #   @return [OpenAI::Models::Beta::Threads::ImageFileDelta, nil]
          optional :image_file, -> { OpenAI::Models::Beta::Threads::ImageFileDelta }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Threads::ImageFileDelta]
          #   attr_writer :image_file

          # @!parse
          #   # References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   #   in the content of a message.
          #   #
          #   # @param index [Integer]
          #   # @param image_file [OpenAI::Models::Beta::Threads::ImageFileDelta]
          #   # @param type [Symbol, :image_file]
          #   #
          #   def initialize(index:, image_file: nil, type: :image_file, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
