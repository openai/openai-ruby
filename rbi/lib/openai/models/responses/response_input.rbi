# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInput =
        T.type_alias do
          T::Array[
          T.any(
            OpenAI::Models::Responses::EasyInputMessage,
            OpenAI::Models::Responses::ResponseInputItem::Message,
            OpenAI::Models::Responses::ResponseOutputMessage,
            OpenAI::Models::Responses::ResponseFileSearchToolCall,
            OpenAI::Models::Responses::ResponseComputerToolCall,
            OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
            OpenAI::Models::Responses::ResponseFunctionWebSearch,
            OpenAI::Models::Responses::ResponseFunctionToolCall,
            OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
            OpenAI::Models::Responses::ResponseReasoningItem,
            OpenAI::Models::Responses::ResponseInputItem::ItemReference
          )
          ]
        end
    end
  end
end
