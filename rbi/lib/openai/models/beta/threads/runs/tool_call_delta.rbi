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
              # @api private
              sig do
                override
                  .returns(
                    [[Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta], [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta], [Symbol, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta]]
                  )
              end
              private def variants
              end
            end
          end
        end
      end
    end
  end
end
