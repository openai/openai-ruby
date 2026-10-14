# typed: strong

module OpenAI
  module Helpers
    module Beta
      module Agents
        class FunctionTool
          sig { returns(String) }
          attr_reader :name

          sig do
            params(
              name: String,
              arguments: T.class_of(OpenAI::BaseModel),
              description: String,
              defer_loading: T.nilable(T::Boolean),
              handler: T.proc.params(arguments: T.untyped).returns(OpenAI::Helpers::Agents::ToolOutput)
            )
              .void
          end
          def initialize(name:, arguments:, description: "", defer_loading: nil, &handler)
          end

          sig { returns(OpenAI::Internal::AnyHash) }
          def definition
          end

          sig { returns(T::Hash[String, OpenAI::Helpers::Agents::ToolHandler]) }
          def handlers
          end

          sig {
            params(
              arguments: T.any(String, OpenAI::Internal::AnyHash),
              report_stage: T.nilable(T.proc.params(stage: Symbol).void)
            )
              .returns(OpenAI::Helpers::Agents::ToolOutput)
          }
          def call(arguments, &report_stage)
          end
        end
      end
    end
  end
end
