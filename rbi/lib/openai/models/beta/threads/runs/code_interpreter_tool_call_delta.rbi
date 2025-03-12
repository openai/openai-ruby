# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCallDelta < OpenAI::BaseModel
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(T.nilable(String)) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter)) }
            def code_interpreter
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter)
                .returns(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter)
            end
            def code_interpreter=(_)
            end

            sig do
              params(
                index: Integer,
                id: String,
                code_interpreter: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(index:, id: nil, code_interpreter: nil, type: :code_interpreter)
            end

            sig do
              override
                .returns(
                  {
                    index: Integer,
                    type: Symbol,
                    id: String,
                    code_interpreter: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter
                  }
                )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::BaseModel
              sig { returns(T.nilable(String)) }
              def input
              end

              sig { params(_: String).returns(String) }
              def input=(_)
              end

              sig do
                returns(
                  T.nilable(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                    )
                    ]
                  )
                )
              end
              def outputs
              end

              sig do
                params(
                  _: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                    )
                    ]
                  )
              end
              def outputs=(_)
              end

              sig do
                params(
                  input: String,
                  outputs: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                  )
                  ]
                )
                  .returns(T.attached_class)
              end
              def self.new(input: nil, outputs: nil)
              end

              sig do
                override
                  .returns(
                    {
                      input: String,
                      outputs: T::Array[
                      T.any(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                      )
                      ]
                    }
                  )
              end
              def to_hash
              end

              class Output < OpenAI::Union
                abstract!

                class << self
                  sig do
                    override
                      .returns(
                        [[Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs], [Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage]]
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
  end
end
