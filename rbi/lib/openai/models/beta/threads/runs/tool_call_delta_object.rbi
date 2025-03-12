# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallDeltaObject < OpenAI::BaseModel
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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
            def tool_calls
            end

            sig do
              params(
                _: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                  OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                  OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                )
                ]
              )
                .returns(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta,
                    OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta
                  )
                  ]
                )
            end
            def tool_calls=(_)
            end

            sig do
              params(
                tool_calls: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
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
