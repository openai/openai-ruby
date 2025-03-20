# typed: strong

module OpenAI
  module Models
    module Responses
      # Content item used to generate a response.
      class ResponseItem < OpenAI::Union
        abstract!

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Responses::ResponseInputMessageItem,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCallItem,
                OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem
              )
            }
          end
      end
    end
  end
end
