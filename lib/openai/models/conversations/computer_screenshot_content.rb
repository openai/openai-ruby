# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class ComputerScreenshotContent < OpenAI::Internal::Type::BaseModel
        # @!attribute detail
        #   The detail level of the screenshot image to be sent to the model. One of `high`,
        #   `low`, `auto`, or `original`. Defaults to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Conversations::ComputerScreenshotContent::Detail]
        required :detail, enum: -> { OpenAI::Conversations::ComputerScreenshotContent::Detail }

        # @!attribute file_id
        #   The identifier of an uploaded file that contains the screenshot.
        #
        #   @return [String, nil]
        required :file_id, String, nil?: true

        # @!attribute image_url
        #   The URL of the screenshot image.
        #
        #   @return [String, nil]
        required :image_url, String, nil?: true

        # @!attribute type
        #   Specifies the event type. For a computer screenshot, this property is always set
        #   to `computer_screenshot`.
        #
        #   @return [Symbol, :computer_screenshot]
        required :type, const: :computer_screenshot

        # @!method initialize(detail:, file_id:, image_url:, type: :computer_screenshot)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::ComputerScreenshotContent} for more details.
        #
        #   A screenshot of a computer.
        #
        #   @param detail [Symbol, OpenAI::Models::Conversations::ComputerScreenshotContent::Detail] The detail level of the screenshot image to be sent to the model. One of `high`,
        #
        #   @param file_id [String, nil] The identifier of an uploaded file that contains the screenshot.
        #
        #   @param image_url [String, nil] The URL of the screenshot image.
        #
        #   @param type [Symbol, :computer_screenshot] Specifies the event type. For a computer screenshot, this property is always set

        # The detail level of the screenshot image to be sent to the model. One of `high`,
        # `low`, `auto`, or `original`. Defaults to `auto`.
        #
        # @see OpenAI::Models::Conversations::ComputerScreenshotContent#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          HIGH = :high
          AUTO = :auto
          ORIGINAL = :original

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
