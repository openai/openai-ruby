# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCallDelta < OpenAI::BaseModel
            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of tool call. This is always going to be `code_interpreter` for this
            #   type of tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            # The ID of the tool call.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The Code Interpreter tool call definition.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter)) }
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                  OpenAI::Internal::Util::AnyHash
                )
              )
                .void
            end
            attr_writer :code_interpreter

            # Details of the Code Interpreter tool call the run step was involved in.
            sig do
              params(
                index: Integer,
                id: String,
                code_interpreter: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                  OpenAI::Internal::Util::AnyHash
                ),
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
              attr_reader :input

              sig { params(input: String).void }
              attr_writer :input

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
              attr_reader :outputs

              sig do
                params(
                  outputs: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                    OpenAI::Internal::Util::AnyHash,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage
                  )
                  ]
                )
                  .void
              end
              attr_writer :outputs

              # The Code Interpreter tool call definition.
              sig do
                params(
                  input: String,
                  outputs: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs,
                    OpenAI::Internal::Util::AnyHash,
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

                sig do
                  override
                    .returns(
                      [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage]
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
  end
end
