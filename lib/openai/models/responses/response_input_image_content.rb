# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputImageContent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_image`.
        #
        #   @return [Symbol, :input_image]
        required :type, const: :input_image

        # @!attribute detail
        #   The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputImageContent::Detail, nil]
        optional :detail, enum: -> { OpenAI::Responses::ResponseInputImageContent::Detail }, nil?: true

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

        # @!method initialize(detail: nil, file_id: nil, image_url: nil, type: :input_image)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInputImageContent} for more details.
        #
        #   An image input to the model. Learn about
        #   [image inputs](https://platform.openai.com/docs/guides/vision)
        #
        #   @param detail [Symbol, OpenAI::Models::Responses::ResponseInputImageContent::Detail, nil] The detail level of the image to be sent to the model. One of `high`, `low`, or
        #
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param image_url [String, nil] The URL of the image to be sent to the model. A fully qualified URL or base64 en
        #
        #   @param type [Symbol, :input_image] The type of the input item. Always `input_image`.

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        #
        # @see OpenAI::Models::Responses::ResponseInputImageContent#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          HIGH = :high
          AUTO = :auto

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
