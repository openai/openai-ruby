# typed: strong

module OpenAI
  module Models
    module Responses
      # Content item used to generate a response.
      module ResponseItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputMessageItem,
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseComputerToolCallOutputItem,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Responses::ResponseFunctionToolCallItem,
              OpenAI::Responses::ResponseFunctionToolCallOutputItem
            )
          end

        sig do
          override.returns(T::Array[OpenAI::Responses::ResponseItem::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
