# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Specify additional output data to include in the model response. Currently
      # supported values are:
      #
      # - `file_search_call.results`: Include the search results of the file search tool
      #   call.
      # - `message.input_image.image_url`: Include image urls from the input message.
      # - `computer_call_output.output.image_url`: Include image urls from the computer
      #   call output.
      module ResponseIncludable
        extend OpenAI::Internal::Type::Enum

        FILE_SEARCH_CALL_RESULTS = :"file_search_call.results"
        MESSAGE_INPUT_IMAGE_IMAGE_URL = :"message.input_image.image_url"
        COMPUTER_CALL_OUTPUT_OUTPUT_IMAGE_URL = :"computer_call_output.output.image_url"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
