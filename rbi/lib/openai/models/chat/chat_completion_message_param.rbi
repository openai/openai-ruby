# typed: strong

module OpenAI
  module Models
    module Chat
      # Developer-provided instructions that the model should follow, regardless of
      #   messages sent by the user. With o1 models and newer, `developer` messages
      #   replace the previous `system` messages.
      module ChatCompletionMessageParam
        extend OpenAI::Union

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
                OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
                OpenAI::Models::Chat::ChatCompletionUserMessageParam,
                OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
                OpenAI::Models::Chat::ChatCompletionToolMessageParam,
                OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
              )
            }
          end
      end
    end

    ChatCompletionMessageParam = Chat::ChatCompletionMessageParam
  end
end
