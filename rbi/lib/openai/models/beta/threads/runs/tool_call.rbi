# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCall < OpenAI::Union
            abstract!

            class << self
              sig do
                override
                  .returns(
                    [[Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall], [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall], [Symbol, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall]]
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
