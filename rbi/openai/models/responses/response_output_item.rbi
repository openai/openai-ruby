# typed: strong

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseFunctionToolCall,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseReasoningItem
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseOutputItem::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
