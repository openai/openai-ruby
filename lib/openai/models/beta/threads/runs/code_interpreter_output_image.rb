# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterOutputImage < OpenAI::BaseModel
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

            # @!attribute [r] image
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image, nil]
            optional :image, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image]
            #   attr_writer :image

            # @!parse
            #   # @param index [Integer]
            #   # @param image [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image]
            #   # @param type [Symbol, :image]
            #   #
            #   def initialize(index:, image: nil, type: :image, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @see OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage#image
            class Image < OpenAI::BaseModel
              # @!attribute [r] file_id
              #   The [file](https://platform.openai.com/docs/api-reference/files) ID of the
              #     image.
              #
              #   @return [String, nil]
              optional :file_id, String

              # @!parse
              #   # @return [String]
              #   attr_writer :file_id

              # @!parse
              #   # @param file_id [String]
              #   #
              #   def initialize(file_id: nil, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void
            end
          end
        end
      end
    end
  end
end
