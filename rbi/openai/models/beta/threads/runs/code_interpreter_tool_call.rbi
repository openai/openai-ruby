# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCall < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the tool call.
            sig { returns(String) }
            attr_accessor :id

            # The Code Interpreter tool call definition.
            sig do
              returns(
                OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter
              )
            end
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::OrHash
              ).void
            end
            attr_writer :code_interpreter

            # The type of tool call. This is always going to be `code_interpreter` for this
            # type of tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            # Details of the Code Interpreter tool call the run step was involved in.
            sig do
              params(
                id: String,
                code_interpreter:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the tool call.
              id:,
              # The Code Interpreter tool call definition.
              code_interpreter:,
              # The type of tool call. This is always going to be `code_interpreter` for this
              # type of tool call.
              type: :code_interpreter
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  code_interpreter:
                    OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The input to the Code Interpreter tool call.
              sig { returns(String) }
              attr_accessor :input

              # The outputs from the Code Interpreter tool call. Code Interpreter can output one
              # or more items, including text (`logs`) or images (`image`). Each of these are
              # represented by a different object type.
              sig do
                returns(
                  T::Array[
                    T.any(
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                    )
                  ]
                )
              end
              attr_accessor :outputs

              # The Code Interpreter tool call definition.
              sig do
                params(
                  input: String,
                  outputs:
                    T::Array[
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs::OrHash,
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::OrHash
                      )
                    ]
                ).returns(T.attached_class)
              end
              def self.new(
                # The input to the Code Interpreter tool call.
                input:,
                # The outputs from the Code Interpreter tool call. Code Interpreter can output one
                # or more items, including text (`logs`) or images (`image`). Each of these are
                # represented by a different object type.
                outputs:
              )
              end

              sig do
                override.returns(
                  {
                    input: String,
                    outputs:
                      T::Array[
                        T.any(
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                        )
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
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                    )
                  end

                class Logs < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # The text output from the Code Interpreter tool call.
                  sig { returns(String) }
                  attr_accessor :logs

                  # Always `logs`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  # Text output from the Code Interpreter tool call as part of a run step.
                  sig do
                    params(logs: String, type: Symbol).returns(T.attached_class)
                  end
                  def self.new(
                    # The text output from the Code Interpreter tool call.
                    logs:,
                    # Always `logs`.
                    type: :logs
                  )
                  end

                  sig { override.returns({ logs: String, type: Symbol }) }
                  def to_hash
                  end
                end

                class Image < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  sig do
                    returns(
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image
                    )
                  end
                  attr_reader :image

                  sig do
                    params(
                      image:
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image::OrHash
                    ).void
                  end
                  attr_writer :image

                  # Always `image`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig do
                    params(
                      image:
                        OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image::OrHash,
                      type: Symbol
                    ).returns(T.attached_class)
                  end
                  def self.new(
                    image:,
                    # Always `image`.
                    type: :image
                  )
                  end

                  sig do
                    override.returns(
                      {
                        image:
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                        type: Symbol
                      }
                    )
                  end
                  def to_hash
                  end

                  class Image < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                    # image.
                    sig { returns(String) }
                    attr_accessor :file_id

                    sig { params(file_id: String).returns(T.attached_class) }
                    def self.new(
                      # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                      # image.
                      file_id:
                    )
                    end

                    sig { override.returns({ file_id: String }) }
                    def to_hash
                    end
                  end
                end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Variants
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
