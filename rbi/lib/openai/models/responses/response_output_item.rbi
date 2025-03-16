# typed: strong

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      class ResponseOutputItem < OpenAI::Union
        abstract!

        Variants = type_template(:out) do
          {
            fixed: T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
            )
          }
        end
      end
    end
  end
end
