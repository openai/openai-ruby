# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputImage < OpenAI::Internal::Type::BaseModel
        # @!attribute detail
        #   The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputImage::Detail]
        required :detail, enum: -> { OpenAI::Models::Responses::ResponseInputImage::Detail }

        # @!attribute type
        #   The type of the input item. Always `input_image`.
        #
        #   @return [Symbol, :input_image]
        required :type, const: :input_image

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String, nil?: true

        # @!attribute image_url
        #   The URL of the image to be sent to the model. A fully qualified URL or base64
        #   encoded image in a data URL.
        #
        #   @return [String, nil]
        optional :image_url, String, nil?: true

        # @!method initialize(detail:, file_id: nil, image_url: nil, type: :input_image)
        #   An image input to the model. Learn about
        #   [image inputs](https://platform.openai.com/docs/guides/vision).
        #
        #   @param detail [Symbol, OpenAI::Models::Responses::ResponseInputImage::Detail]
        #   @param file_id [String, nil]
        #   @param image_url [String, nil]
        #   @param type [Symbol, :input_image]

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        #
        # @see OpenAI::Models::Responses::ResponseInputImage#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          HIGH = :high
          LOW = :low
          AUTO = :auto

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
