# typed: strong

module OpenAI
  module Models
    module Beta
      module AssistantTool
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool]
            )
        end
        def self.variants
        end
      end
    end
  end
end
