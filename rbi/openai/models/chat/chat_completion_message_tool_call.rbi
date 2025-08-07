# typed: strong

module OpenAI
  module Models
    ChatCompletionMessageToolCall = Chat::ChatCompletionMessageToolCall

    module Chat
      # A call to a function tool created by the model.
      module ChatCompletionMessageToolCall
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionMessageFunctionToolCall,
              OpenAI::Chat::ChatCompletionMessageCustomToolCall
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionMessageToolCall::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
