# typed: strong

module OpenAI
  module Models
    module Responses
      # A tool that searches for relevant content from uploaded files. Learn more about
      # the
      # [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
      module Tool
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::FileSearchTool,
              OpenAI::Responses::FunctionTool,
              OpenAI::Responses::ComputerTool,
              OpenAI::Responses::WebSearchTool
            )
          end

        sig { override.returns(T::Array[OpenAI::Responses::Tool::Variants]) }
        def self.variants
        end
      end
    end
  end
end
