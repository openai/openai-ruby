# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallsStepDetails < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # An array of tool calls the run step was involved in. These can be associated
            # with one of three types of tools: `code_interpreter`, `file_search`, or
            # `function`.
            sig do
              returns(
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall,
                    OpenAI::Beta::Threads::Runs::FileSearchToolCall,
                    OpenAI::Beta::Threads::Runs::FunctionToolCall
                  )
                ]
              )
            end
            attr_accessor :tool_calls

            # Always `tool_calls`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Details of the tool call.
            sig do
              params(
                tool_calls:
                  T::Array[
                    T.any(
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::OrHash,
                      OpenAI::Beta::Threads::Runs::FileSearchToolCall::OrHash,
                      OpenAI::Beta::Threads::Runs::FunctionToolCall::OrHash
                    )
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # An array of tool calls the run step was involved in. These can be associated
              # with one of three types of tools: `code_interpreter`, `file_search`, or
              # `function`.
              tool_calls:,
              # Always `tool_calls`.
              type: :tool_calls
            )
            end

            sig do
              override.returns(
                {
                  tool_calls:
                    T::Array[
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall,
                        OpenAI::Beta::Threads::Runs::FileSearchToolCall,
                        OpenAI::Beta::Threads::Runs::FunctionToolCall
                      )
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
