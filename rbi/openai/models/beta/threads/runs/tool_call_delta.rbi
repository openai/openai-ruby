# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          module ToolCallDelta
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                  OpenAI::Beta::Threads::Runs::FileSearchToolCallDelta,
                  OpenAI::Beta::Threads::Runs::FunctionToolCallDelta
                )
              end

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::Runs::ToolCallDelta::Variants]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
