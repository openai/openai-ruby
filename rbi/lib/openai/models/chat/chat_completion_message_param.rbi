# typed: strong

module OpenAI
  module Models
    ChatCompletionMessageParam = T.type_alias { Chat::ChatCompletionMessageParam }

    module Chat
      class ChatCompletionMessageParam < OpenAI::Union
        abstract!

        class << self
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
