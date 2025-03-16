# typed: strong

module OpenAI
  module Models
    module Responses
      # Specify additional output data to include in the model response. Currently
      #   supported values are:
      #
      #   - `file_search_call.results`: Include the search results of the file search tool
      #     call.
      #   - `message.input_image.image_url`: Include image urls from the input message.
      #   - `computer_call_output.output.image_url`: Include image urls from the computer
      #     call output.
      class ResponseIncludable < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        FILE_SEARCH_CALL_RESULTS = :"file_search_call.results"
        MESSAGE_INPUT_IMAGE_IMAGE_URL = :"message.input_image.image_url"
        COMPUTER_CALL_OUTPUT_OUTPUT_IMAGE_URL = :"computer_call_output.output.image_url"
      end
    end
  end
end
