# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCallDelta < OpenAI::BaseModel
            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # The type of tool call. This is always going to be `code_interpreter` for this
            #   type of tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The ID of the tool call.
            sig { returns(T.nilable(String)) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The Code Interpreter tool call definition.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter)) }
            def code_interpreter
            end

            sig do
              params(
                _: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                  OpenAI::Util::AnyHash
                )
              )
                .returns(
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                    OpenAI::Util::AnyHash
                  )
                )
            end
            def code_interpreter=(_)
            end

            # Details of the Code Interpreter tool call the run step was involved in.
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
              # The input to the Code Interpreter tool call.
              sig { returns(T.nilable(String)) }
              def input
              end

              sig { params(_: String).returns(String) }
              def input=(_)
              end

              # The outputs from the Code Interpreter tool call. Code Interpreter can output one
              #   or more items, including text (`logs`) or images (`image`). Each of these are
              #   represented by a different object type.
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

              # The Code Interpreter tool call definition.
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

              # Text output from the Code Interpreter tool call as part of a run step.
              module Output
                extend OpenAI::Union

                Variants =
                  type_template(:out) do
                    {
                      fixed: T.any(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                      )
                    }
                  end

                class << self
                  sig do
                    override
                      .returns(
                        [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage]
                      )
                  end
                  def variants
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
