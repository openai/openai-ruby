# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantTool < OpenAI::Union
        abstract!

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
      end
    end
  end
end
