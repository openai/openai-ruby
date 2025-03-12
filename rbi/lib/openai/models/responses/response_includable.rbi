# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseIncludable < OpenAI::Enum
        abstract!

        FILE_SEARCH_CALL_RESULTS = :"file_search_call.results"
        MESSAGE_INPUT_IMAGE_IMAGE_URL = :"message.input_image.image_url"
        COMPUTER_CALL_OUTPUT_OUTPUT_IMAGE_URL = :"computer_call_output.output.image_url"

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
