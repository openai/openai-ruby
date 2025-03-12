# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallsStepDetails < OpenAI::BaseModel
            sig do
              returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
                )
                ]
              )
            end
            def tool_calls
            end

            sig do
              params(
                _: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
                )
                ]
              )
                .returns(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                    OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
                  )
                  ]
                )
            end
            def tool_calls=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                tool_calls: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
                )
                ],
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(tool_calls:, type: :tool_calls)
            end

            sig do
              override
                .returns(
                  {
                    tool_calls: T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall,
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall,
                      OpenAI::Models::Beta::Threads::Runs::FunctionToolCall
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
