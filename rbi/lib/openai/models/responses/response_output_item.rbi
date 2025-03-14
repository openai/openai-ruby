# typed: strong

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      class ResponseOutputItem < OpenAI::Union
        abstract!

        class << self
          # @api private
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
