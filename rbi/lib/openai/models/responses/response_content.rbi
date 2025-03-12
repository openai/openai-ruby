# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContent < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[NilClass, OpenAI::Models::Responses::ResponseInputText], [NilClass, OpenAI::Models::Responses::ResponseInputImage], [NilClass, OpenAI::Models::Responses::ResponseInputFile], [NilClass, OpenAI::Models::Responses::ResponseOutputText], [NilClass, OpenAI::Models::Responses::ResponseOutputRefusal]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
