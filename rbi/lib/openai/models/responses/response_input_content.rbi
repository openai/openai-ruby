# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      module ResponseInputContent
        extend OpenAI::Union

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

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
