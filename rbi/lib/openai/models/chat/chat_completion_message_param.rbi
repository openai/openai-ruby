# typed: strong

module OpenAI
  module Models
    ChatCompletionMessageParam = T.type_alias { Chat::ChatCompletionMessageParam }

    module Chat
      # Developer-provided instructions that the model should follow, regardless of
      #   messages sent by the user. With o1 models and newer, `developer` messages
      #   replace the previous `system` messages.
      class ChatCompletionMessageParam < OpenAI::Union
        abstract!

        class << self
          # @api private
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam], [Symbol, OpenAI::Models::Chat::ChatCompletionSystemMessageParam], [Symbol, OpenAI::Models::Chat::ChatCompletionUserMessageParam], [Symbol, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam], [Symbol, OpenAI::Models::Chat::ChatCompletionToolMessageParam], [Symbol, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
