# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class ComputerScreenshotContent < OpenAI::Internal::Type::BaseModel
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

        # @!method initialize(file_id:, image_url:, type: :computer_screenshot)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::ComputerScreenshotContent} for more details.
        #
        #   A screenshot of a computer.
        #
        #   @param file_id [String, nil] The identifier of an uploaded file that contains the screenshot.
        #
        #   @param image_url [String, nil] The URL of the screenshot image.
        #
        #   @param type [Symbol, :computer_screenshot] Specifies the event type. For a computer screenshot, this property is always set
      end
    end
  end
end
