# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallDeltaObject < OpenAI::Internal::Type::BaseModel
            # Always `tool_calls`.
            sig { returns(Symbol) }
            attr_accessor :type

            # An array of tool calls the run step was involved in. These can be associated
            #   with one of three types of tools: `code_interpreter`, `file_search`, or
            #   `function`.
            sig do
              returns(
                T.nilable(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                    OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                  )
                  ]
                )
              )
            end
            attr_reader :tool_calls

            sig do
              params(
                tool_calls: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                )
                ]
              )
                .void
            end
            attr_writer :tool_calls

            # Details of the tool call.
            sig do
              params(
                tool_calls: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                )
                ],
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(tool_calls: nil, type: :tool_calls)
            end

            sig do
              override
                .returns(
                  {
                    type: Symbol,
                    tool_calls: T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                      OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                    )
                    ]
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
