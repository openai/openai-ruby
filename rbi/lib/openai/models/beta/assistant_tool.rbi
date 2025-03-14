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
