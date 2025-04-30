# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputScreenshot < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Specifies the event type. For a computer screenshot, this property is always set
        #   to `computer_screenshot`.
        #
        #   @return [Symbol, :computer_screenshot]
        required :type, const: :computer_screenshot

        # @!attribute file_id
        #   The identifier of an uploaded file that contains the screenshot.
        #
        #   @return [String, nil]
        optional :file_id, String

        # @!attribute image_url
        #   The URL of the screenshot image.
        #
        #   @return [String, nil]
        optional :image_url, String

        # @!method initialize(file_id: nil, image_url: nil, type: :computer_screenshot)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot} for more
        #   details.
        #
        #   A computer screenshot image used with the computer use tool.
        #
        #   @param file_id [String] The identifier of an uploaded file that contains the screenshot.
        #
        #   @param image_url [String] The URL of the screenshot image.
        #
        #   @param type [Symbol, :computer_screenshot] Specifies the event type. For a computer screenshot, this property is ...
      end
    end
  end
end
