# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A tool that can be used to generate a response.
      module Tool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A tool that searches for relevant content from uploaded files. Learn more about the [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        variant :file_search, -> { OpenAI::Responses::FileSearchTool }

        # Defines a function in your own code the model can choose to call. Learn more about [function calling](https://platform.openai.com/docs/guides/function-calling).
        variant :function, -> { OpenAI::Responses::FunctionTool }

        # A tool that controls a virtual computer. Learn more about the [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        variant :computer_use_preview, -> { OpenAI::Responses::ComputerTool }

        # This tool searches the web for relevant results to use in a response. Learn more about the [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        variant -> { OpenAI::Responses::WebSearchTool }

        # @!method self.variants
        #   @return [Array(OpenAI::Responses::FileSearchTool, OpenAI::Responses::FunctionTool, OpenAI::Responses::ComputerTool, OpenAI::Responses::WebSearchTool)]
      end
    end
  end
end
