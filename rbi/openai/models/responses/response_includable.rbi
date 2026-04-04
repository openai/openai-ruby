# typed: strong

module OpenAI
  module Models
    module Responses
      # Specify additional output data to include in the model response. Currently
      # supported values are:
      #
      # - `web_search_call.action.sources`: Include the sources of the web search tool
      #   call.
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

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseIncludable) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        FILE_SEARCH_CALL_RESULTS =
          T.let(
            :"file_search_call.results",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        WEB_SEARCH_CALL_RESULTS =
          T.let(
            :"web_search_call.results",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        WEB_SEARCH_CALL_ACTION_SOURCES =
          T.let(
            :"web_search_call.action.sources",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        MESSAGE_INPUT_IMAGE_IMAGE_URL =
          T.let(
            :"message.input_image.image_url",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        COMPUTER_CALL_OUTPUT_OUTPUT_IMAGE_URL =
          T.let(
            :"computer_call_output.output.image_url",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        CODE_INTERPRETER_CALL_OUTPUTS =
          T.let(
            :"code_interpreter_call.outputs",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        REASONING_ENCRYPTED_CONTENT =
          T.let(
            :"reasoning.encrypted_content",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )
        MESSAGE_OUTPUT_TEXT_LOGPROBS =
          T.let(
            :"message.output_text.logprobs",
            OpenAI::Responses::ResponseIncludable::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseIncludable::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
