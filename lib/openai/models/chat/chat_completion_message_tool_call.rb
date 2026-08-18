# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # A call to a function tool created by the model.
      module ChatCompletionMessageToolCall
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A call to a function tool created by the model.
        variant :function, -> { OpenAI::Chat::ChatCompletionMessageFunctionToolCall }

        # A call to a custom tool created by the model.
        variant :custom, -> { OpenAI::Chat::ChatCompletionMessageCustomToolCall }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Chat::ChatCompletionMessageFunctionToolCall, OpenAI::Models::Chat::ChatCompletionMessageCustomToolCall)]
      end
    end

    ChatCompletionMessageToolCall = Chat::ChatCompletionMessageToolCall
  end
end
