# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputContent < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Responses::ResponseInputText], [Symbol, OpenAI::Models::Responses::ResponseInputImage], [Symbol, OpenAI::Models::Responses::ResponseInputFile]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
