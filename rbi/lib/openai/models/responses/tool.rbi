# typed: strong

module OpenAI
  module Models
    module Responses
      class Tool < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Responses::FileSearchTool], [Symbol, OpenAI::Models::Responses::FunctionTool], [Symbol, OpenAI::Models::Responses::ComputerTool], [NilClass, OpenAI::Models::Responses::WebSearchTool]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
