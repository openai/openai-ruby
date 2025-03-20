# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # Developer-provided instructions that the model should follow, regardless of
      #   messages sent by the user. With o1 models and newer, `developer` messages
      #   replace the previous `system` messages.
      module ChatCompletionMessageParam
        extend OpenAI::Union

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

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam)]
        #     def variants; end
        #   end
      end
    end

    ChatCompletionMessageParam = Chat::ChatCompletionMessageParam
  end
end
