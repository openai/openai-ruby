# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A tool that searches for relevant content from uploaded files. Learn more about
      # the
      # [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
      module Tool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A tool that searches for relevant content from uploaded files.
        # Learn more about the [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        variant :file_search, -> { OpenAI::Models::Responses::FileSearchTool }

        # Defines a function in your own code the model can choose to call. Learn more
        # about [function calling](https://platform.openai.com/docs/guides/function-calling).
        variant :function, -> { OpenAI::Models::Responses::FunctionTool }

        # A tool that controls a virtual computer. Learn more about the
        # [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        variant :computer_use_preview, -> { OpenAI::Models::Responses::ComputerTool }

        # This tool searches the web for relevant results to use in a response.
        # Learn more about the [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        variant -> { OpenAI::Models::Responses::WebSearchTool }

        # @!parse
        #   # @return [Array(OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool)]
        #   def self.variants; end
      end
    end
  end
end
