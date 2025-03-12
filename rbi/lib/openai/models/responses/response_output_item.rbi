# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItem < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Responses::ResponseOutputMessage], [Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall], [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall], [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall], [Symbol, OpenAI::Models::Responses::ResponseReasoningItem]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
