# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      class ResponseInputContent < OpenAI::Union
        abstract!

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
