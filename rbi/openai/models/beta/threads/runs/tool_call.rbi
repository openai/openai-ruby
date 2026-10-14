# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          module ToolCall
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall,
                  OpenAI::Beta::Threads::Runs::FileSearchToolCall,
                  OpenAI::Beta::Threads::Runs::FunctionToolCall
                )
              end

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::Runs::ToolCall::Variants]
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
