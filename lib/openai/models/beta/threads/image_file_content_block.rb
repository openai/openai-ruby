# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileContentBlock < OpenAI::BaseModel
          # @!attribute image_file
          #
          #   @return [OpenAI::Models::Beta::Threads::ImageFile]
          required :image_file, -> { OpenAI::Models::Beta::Threads::ImageFile }

          # @!attribute type
          #   Always `image_file`.
          #
          #   @return [Symbol, :image_file]
          required :type, const: :image_file

          # @!parse
          #   # References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   #   in the content of a message.
          #   #
          #   # @param image_file [OpenAI::Models::Beta::Threads::ImageFile]
          #   # @param type [Symbol, :image_file]
          #   #
          #   def initialize(image_file:, type: :image_file, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
