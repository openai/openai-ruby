# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # An output message from the model.
        variant :message, -> { OpenAI::Models::Responses::ResponseOutputMessage }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Models::Responses::ResponseFileSearchToolCall }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Models::Responses::ResponseFunctionToolCall }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Models::Responses::ResponseFunctionWebSearch }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Models::Responses::ResponseComputerToolCall }

        # A description of the chain of thought used by a reasoning model while generating
        # a response.
        variant :reasoning, -> { OpenAI::Models::Responses::ResponseReasoningItem }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem)]
      end
    end
  end
end
