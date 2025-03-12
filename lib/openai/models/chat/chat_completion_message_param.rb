# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @abstract
      #
      # Developer-provided instructions that the model should follow, regardless of
      #   messages sent by the user. With o1 models and newer, `developer` messages
      #   replace the previous `system` messages.
      class ChatCompletionMessageParam < OpenAI::Union
        discriminator :role

        # Developer-provided instructions that the model should follow, regardless of
        # messages sent by the user. With o1 models and newer, `developer` messages
        # replace the previous `system` messages.
        variant :developer, -> { OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam }

        # Developer-provided instructions that the model should follow, regardless of
        # messages sent by the user. With o1 models and newer, use `developer` messages
        # for this purpose instead.
        variant :system, -> { OpenAI::Models::Chat::ChatCompletionSystemMessageParam }

        # Messages sent by an end user, containing prompts or additional context
        # information.
        variant :user, -> { OpenAI::Models::Chat::ChatCompletionUserMessageParam }

        # Messages sent by the model in response to user messages.
        variant :assistant, -> { OpenAI::Models::Chat::ChatCompletionAssistantMessageParam }

        variant :tool, -> { OpenAI::Models::Chat::ChatCompletionToolMessageParam }

        variant :function, -> { OpenAI::Models::Chat::ChatCompletionFunctionMessageParam }
      end
    end

    ChatCompletionMessageParam = Chat::ChatCompletionMessageParam
  end
end
