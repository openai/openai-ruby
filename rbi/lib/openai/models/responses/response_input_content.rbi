# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      class ResponseInputContent < OpenAI::Union
        abstract!

        class << self
          # @api private
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
