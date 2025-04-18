# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterOutputImage < OpenAI::Internal::Type::BaseModel
            # @!attribute index
            #   The index of the output in the outputs array.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   Always `image`.
            #
            #   @return [Symbol, :image]
            required :type, const: :image

            # @!attribute image
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image, nil]
            optional :image, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image }

            # @!method initialize(index:, image: nil, type: :image)
            #   @param index [Integer]
            #   @param image [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image]
            #   @param type [Symbol, :image]

            # @see OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage#image
            class Image < OpenAI::Internal::Type::BaseModel
              # @!attribute file_id
              #   The [file](https://platform.openai.com/docs/api-reference/files) ID of the
              #   image.
              #
              #   @return [String, nil]
              optional :file_id, String

              # @!method initialize(file_id: nil)
              #   @param file_id [String]
            end
          end
        end
      end
    end
  end
end
