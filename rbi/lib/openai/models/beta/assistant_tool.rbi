# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantTool < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Beta::CodeInterpreterTool], [Symbol, OpenAI::Models::Beta::FileSearchTool], [Symbol, OpenAI::Models::Beta::FunctionTool]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
