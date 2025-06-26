# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Specify additional output data to include in the model response. Currently
      # supported values are:
      #
      # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
      #   in code interpreter tool call items.
      # - `computer_call_output.output.image_url`: Include image urls from the computer
      #   call output.
      # - `file_search_call.results`: Include the search results of the file search tool
      #   call.
      # - `message.input_image.image_url`: Include image urls from the input message.
      # - `message.output_text.logprobs`: Include logprobs with assistant messages.
      # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
      #   tokens in reasoning item outputs. This enables reasoning items to be used in
      #   multi-turn conversations when using the Responses API statelessly (like when
      #   the `store` parameter is set to `false`, or when an organization is enrolled
      #   in the zero data retention program).
      module ResponseIncludable
        extend OpenAI::Internal::Type::Enum

        CODE_INTERPRETER_CALL_OUTPUTS = :"code_interpreter_call.outputs"
        COMPUTER_CALL_OUTPUT_OUTPUT_IMAGE_URL = :"computer_call_output.output.image_url"
        FILE_SEARCH_CALL_RESULTS = :"file_search_call.results"
        MESSAGE_INPUT_IMAGE_IMAGE_URL = :"message.input_image.image_url"
        MESSAGE_OUTPUT_TEXT_LOGPROBS = :"message.output_text.logprobs"
        REASONING_ENCRYPTED_CONTENT = :"reasoning.encrypted_content"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
