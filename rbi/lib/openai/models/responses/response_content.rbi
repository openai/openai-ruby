# typed: strong

module OpenAI
  module Models
    module Responses
      # Multi-modal input and output contents.
      class ResponseContent < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
