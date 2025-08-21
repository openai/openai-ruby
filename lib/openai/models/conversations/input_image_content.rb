# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class InputImageContent < OpenAI::Internal::Type::BaseModel
        # @!attribute detail
        #   The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Conversations::InputImageContent::Detail]
        required :detail, enum: -> { OpenAI::Conversations::InputImageContent::Detail }

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        required :file_id, String, nil?: true

        # @!attribute image_url
        #   The URL of the image to be sent to the model. A fully qualified URL or base64
        #   encoded image in a data URL.
        #
        #   @return [String, nil]
        required :image_url, String, nil?: true

        # @!attribute type
        #   The type of the input item. Always `input_image`.
        #
        #   @return [Symbol, :input_image]
        required :type, const: :input_image

        # @!method initialize(detail:, file_id:, image_url:, type: :input_image)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::InputImageContent} for more details.
        #
        #   @param detail [Symbol, OpenAI::Models::Conversations::InputImageContent::Detail] The detail level of the image to be sent to the model. One of `high`, `low`, or
        #
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param image_url [String, nil] The URL of the image to be sent to the model. A fully qualified URL or base64 en
        #
        #   @param type [Symbol, :input_image] The type of the input item. Always `input_image`.

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        #
        # @see OpenAI::Models::Conversations::InputImageContent#detail
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
