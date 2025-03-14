# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          class ToolCallDelta < OpenAI::Union
            abstract!

            class << self
              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta]
                  )
              end
              def variants
              end
            end
          end
        end
      end
    end
  end
end
