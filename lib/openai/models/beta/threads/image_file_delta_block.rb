# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDeltaBlock < OpenAI::Internal::Type::BaseModel
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

          # @!attribute image_file
          #
          #   @return [OpenAI::Models::Beta::Threads::ImageFileDelta, nil]
          optional :image_file, -> { OpenAI::Models::Beta::Threads::ImageFileDelta }

          # @!method initialize(index:, image_file: nil, type: :image_file)
          #   References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   in the content of a message.
          #
          #   @param index [Integer] The index of the content part in the message.
          #
          #   @param image_file [OpenAI::Models::Beta::Threads::ImageFileDelta]
          #
          #   @param type [Symbol, :image_file] Always `image_file`.
        end
      end
    end
  end
end
