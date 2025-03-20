# typed: strong

module OpenAI
  module Models
    module Beta
      module AssistantTool
        extend OpenAI::Union

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
            }
          end

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
