# typed: strong

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

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseIncludable) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        FILE_SEARCH_CALL_RESULTS =
          T.let(
            :"file_search_call.results",
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
