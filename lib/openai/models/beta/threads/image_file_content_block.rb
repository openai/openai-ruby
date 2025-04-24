# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileContentBlock < OpenAI::Internal::Type::BaseModel
          # @!attribute image_file
          #
          #   @return [OpenAI::Models::Beta::Threads::ImageFile]
          required :image_file, -> { OpenAI::Models::Beta::Threads::ImageFile }

          # @!attribute type
          #   Always `image_file`.
          #
          #   @return [Symbol, :image_file]
          required :type, const: :image_file

          # @!method initialize(image_file:, type: :image_file)
          #   References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   in the content of a message.
          #
          #   @param image_file [OpenAI::Models::Beta::Threads::ImageFile]
          #
          #   @param type [Symbol, :image_file] Always `image_file`.
        end
      end
    end
  end
end
