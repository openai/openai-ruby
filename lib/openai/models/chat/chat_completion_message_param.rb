# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # Developer-provided instructions that the model should follow, regardless of
      # messages sent by the user. With o1 models and newer, `developer` messages
      # replace the previous `system` messages.
      module ChatCompletionMessageParam
        extend OpenAI::Internal::Type::Union

        discriminator :role

        # Developer-provided instructions that the model should follow, regardless of
        # messages sent by the user. With o1 models and newer, `developer` messages
        # replace the previous `system` messages.
        variant :developer, -> { OpenAI::Chat::ChatCompletionDeveloperMessageParam }

        # Developer-provided instructions that the model should follow, regardless of
        # messages sent by the user. With o1 models and newer, use `developer` messages
        # for this purpose instead.
        variant :system, -> { OpenAI::Chat::ChatCompletionSystemMessageParam }

        # Messages sent by an end user, containing prompts or additional context
        # information.
        variant :user, -> { OpenAI::Chat::ChatCompletionUserMessageParam }

        # Messages sent by the model in response to user messages.
        variant :assistant, -> { OpenAI::Chat::ChatCompletionAssistantMessageParam }

        variant :tool, -> { OpenAI::Chat::ChatCompletionToolMessageParam }

        variant :function, -> { OpenAI::Chat::ChatCompletionFunctionMessageParam }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam)]
      end
    end

    ChatCompletionMessageParam = Chat::ChatCompletionMessageParam
  end
end
