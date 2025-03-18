# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputScreenshot < OpenAI::BaseModel
        # @!attribute type
        #   Specifies the event type. For a computer screenshot, this property is always set
        #     to `computer_screenshot`.
        #
        #   @return [Symbol, :computer_screenshot]
        required :type, const: :computer_screenshot

        # @!attribute [r] file_id
        #   The identifier of an uploaded file that contains the screenshot.
        #
        #   @return [String, nil]
        optional :file_id, String

        # @!parse
        #   # @return [String]
        #   attr_writer :file_id

        # @!attribute [r] image_url
        #   The URL of the screenshot image.
        #
        #   @return [String, nil]
        optional :image_url, String

        # @!parse
        #   # @return [String]
        #   attr_writer :image_url

        # @!parse
        #   # A computer screenshot image used with the computer use tool.
        #   #
        #   # @param file_id [String]
        #   # @param image_url [String]
        #   # @param type [Symbol, :computer_screenshot]
        #   #
        #   def initialize(file_id: nil, image_url: nil, type: :computer_screenshot, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
