# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFormatTextConfig < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::ResponseFormatText], [Symbol, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig], [Symbol, OpenAI::Models::ResponseFormatJSONObject]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
