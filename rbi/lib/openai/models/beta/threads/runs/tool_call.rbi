# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          class ToolCall < OpenAI::Union
            abstract!

            Variants =
              type_template(:out) do
                {
                  fixed: T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                    OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
                  )
                }
              end
          end
        end
      end
    end
  end
end
