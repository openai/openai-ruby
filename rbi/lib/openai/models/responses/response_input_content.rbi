# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      class ResponseInputContent < OpenAI::Union
        abstract!

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
            }
          end
      end
    end
  end
end
