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
          # @api private
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Responses::FileSearchTool], [Symbol, OpenAI::Models::Responses::FunctionTool], [Symbol, OpenAI::Models::Responses::ComputerTool], [NilClass, OpenAI::Models::Responses::WebSearchTool]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
