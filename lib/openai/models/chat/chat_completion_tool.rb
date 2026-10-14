# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # A function tool that can be used to generate a response.
      module ChatCompletionTool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A function tool that can be used to generate a response.
        variant :function, -> { OpenAI::Chat::ChatCompletionFunctionTool }

        # A custom tool that processes input using a specified format.
        variant :custom, -> { OpenAI::Chat::ChatCompletionCustomTool }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Chat::ChatCompletionFunctionTool, OpenAI::Models::Chat::ChatCompletionCustomTool)]
      end
    end

    ChatCompletionTool = Chat::ChatCompletionTool
  end
end
