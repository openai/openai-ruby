# typed: strong

module OpenAI
  module Models
    ChatCompletionTool = Chat::ChatCompletionTool

    module Chat
      # A function tool that can be used to generate a response.
      module ChatCompletionTool
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionFunctionTool,
              OpenAI::Chat::ChatCompletionCustomTool
            )
          end

        sig do
          override.returns(T::Array[OpenAI::Chat::ChatCompletionTool::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
