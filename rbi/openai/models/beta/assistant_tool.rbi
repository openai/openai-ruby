# typed: strong
# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

module OpenAI
  module Models
    module Beta
      module AssistantTool
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::CodeInterpreterTool,
              OpenAI::Beta::FileSearchTool,
              OpenAI::Beta::FunctionTool
            )
          end

        sig do
          override.returns(T::Array[OpenAI::Beta::AssistantTool::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
