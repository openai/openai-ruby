# typed: strong

module OpenAI
  module Models
    module Responses
      # A tool that searches for relevant content from uploaded files. Learn more about
      #   the
      #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
      class Tool < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
