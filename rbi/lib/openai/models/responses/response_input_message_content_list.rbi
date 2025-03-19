# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInputMessageContentList =
        T.type_alias do
          T::Array[
          T.any(
            OpenAI::Models::Responses::ResponseInputText,
            OpenAI::Models::Responses::ResponseInputImage,
            OpenAI::Models::Responses::ResponseInputFile
          )
          ]
        end
    end
  end
end
