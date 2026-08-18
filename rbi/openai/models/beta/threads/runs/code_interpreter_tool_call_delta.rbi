# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCallDelta < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta,
                  OpenAI::Internal::AnyHash
                )
              end

            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of tool call. This is always going to be `code_interpreter` for this
            # type of tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            # The ID of the tool call.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The Code Interpreter tool call definition.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter
                )
              )
            end
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::OrHash
              ).void
            end
            attr_writer :code_interpreter

            # Details of the Code Interpreter tool call the run step was involved in.
            sig do
              params(
                index: Integer,
                id: String,
                code_interpreter:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The index of the tool call in the tool calls array.
              index:,
              # The ID of the tool call.
              id: nil,
              # The Code Interpreter tool call definition.
              code_interpreter: nil,
              # The type of tool call. This is always going to be `code_interpreter` for this
              # type of tool call.
              type: :code_interpreter
            )
            end

            sig do
              override.returns(
                {
                  index: Integer,
                  type: Symbol,
                  id: String,
                  code_interpreter:
                    OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The input to the Code Interpreter tool call.
              sig { returns(T.nilable(String)) }
              attr_reader :input

              sig { params(input: String).void }
              attr_writer :input

              # The outputs from the Code Interpreter tool call. Code Interpreter can output one
              # or more items, including text (`logs`) or images (`image`). Each of these are
              # represented by a different object type.
              sig do
                returns(
                  T.nilable(
                    T::Array[
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::Output::Variants
                    ]
                  )
                )
              end
              attr_reader :outputs

              sig do
                params(
                  outputs:
                    T::Array[
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterLogs::OrHash,
                        OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::OrHash
                      )
                    ]
                ).void
              end
              attr_writer :outputs

              # The Code Interpreter tool call definition.
              sig do
                params(
                  input: String,
                  outputs:
                    T::Array[
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterLogs::OrHash,
                        OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::OrHash
                      )
                    ]
                ).returns(T.attached_class)
              end
              def self.new(
                # The input to the Code Interpreter tool call.
                input: nil,
                # The outputs from the Code Interpreter tool call. Code Interpreter can output one
                # or more items, including text (`logs`) or images (`image`). Each of these are
                # represented by a different object type.
                outputs: nil
              )
              end

              sig do
                override.returns(
                  {
                    input: String,
                    outputs:
                      T::Array[
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::Output::Variants
                      ]
                  }
                )
              end
              def to_hash
              end

              # Text output from the Code Interpreter tool call as part of a run step.
              module Output
                extend OpenAI::Internal::Type::Union

                Variants =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::Threads::Runs::CodeInterpreterLogs,
                      OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage
                    )
                  end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::Output::Variants
                    ]
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
