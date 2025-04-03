# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Content item used to generate a response.
      module ResponseItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :message, -> { OpenAI::Models::Responses::ResponseInputMessageItem }

        # An output message from the model.
        variant :message, -> { OpenAI::Models::Responses::ResponseOutputMessage }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Models::Responses::ResponseFileSearchToolCall }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Models::Responses::ResponseComputerToolCall }

        variant :computer_call_output, -> { OpenAI::Models::Responses::ResponseComputerToolCallOutputItem }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Models::Responses::ResponseFunctionWebSearch }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Models::Responses::ResponseFunctionToolCallItem }

        variant :function_call_output, -> { OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem }

        # @!parse
        #   # @return [Array(OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem)]
        #   def self.variants; end
      end
    end
  end
end
