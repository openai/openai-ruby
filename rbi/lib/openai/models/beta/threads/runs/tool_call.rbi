# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          class ToolCall < OpenAI::Union
            abstract!

            class << self
              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall]
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
