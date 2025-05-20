# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # An output message from the model.
        variant :message, -> { OpenAI::Responses::ResponseOutputMessage }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Responses::ResponseFileSearchToolCall }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Responses::ResponseFunctionToolCall }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Responses::ResponseFunctionWebSearch }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Responses::ResponseComputerToolCall }

        # A description of the chain of thought used by a reasoning model while generating
        # a response. Be sure to include these items in your `input` to the Responses API
        # for subsequent turns of a conversation if you are manually
        # [managing context](https://platform.openai.com/docs/guides/conversation-state).
        variant :reasoning, -> { OpenAI::Responses::ResponseReasoningItem }

        # @!method self.variants
        #   @return [Array(OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseReasoningItem)]
      end
    end
  end
end
