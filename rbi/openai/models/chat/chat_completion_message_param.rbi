# typed: strong

module OpenAI
  module Models
    ChatCompletionMessageParam = Chat::ChatCompletionMessageParam

    module Chat
      # Developer-provided instructions that the model should follow, regardless of
      # messages sent by the user. With o1 models and newer, `developer` messages
      # replace the previous `system` messages.
      module ChatCompletionMessageParam
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Chat::ChatCompletionUserMessageParam,
              OpenAI::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Chat::ChatCompletionToolMessageParam,
              OpenAI::Chat::ChatCompletionFunctionMessageParam
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionMessageParam::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
