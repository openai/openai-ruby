# typed: strong

module OpenAI
  module Models
    module Responses
      # A tool that can be used to generate a response.
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
