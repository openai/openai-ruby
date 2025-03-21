# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      module ResponseInputContent
        extend OpenAI::Union

        sig do
          override
            .returns(
              [OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile]
            )
        end
        def self.variants
        end
      end
    end
  end
end
