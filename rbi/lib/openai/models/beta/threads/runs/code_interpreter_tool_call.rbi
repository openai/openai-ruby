# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCall < OpenAI::BaseModel
            # The ID of the tool call.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The Code Interpreter tool call definition.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter) }
            def code_interpreter
            end

            sig do
              params(
                _: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                  OpenAI::Util::AnyHash
                )
              )
                .returns(
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                    OpenAI::Util::AnyHash
                  )
                )
            end
            def code_interpreter=(_)
            end

            # The type of tool call. This is always going to be `code_interpreter` for this
            #   type of tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # Details of the Code Interpreter tool call the run step was involved in.
            sig do
              params(
                id: String,
                code_interpreter: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                  OpenAI::Util::AnyHash
                ),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, code_interpreter:, type: :code_interpreter)
            end

            sig do
              override
                .returns(
                  {
                    id: String,
                    code_interpreter: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::BaseModel
              # The input to the Code Interpreter tool call.
              sig { returns(String) }
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
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                  )
                  ]
                )
              end
              def outputs
              end

              sig do
                params(
                  _: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
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
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                    OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                  )
                  ]
                )
                  .returns(T.attached_class)
              end
              def self.new(input:, outputs:)
              end

              sig do
                override
                  .returns(
                    {
                      input: String,
                      outputs: T::Array[
                      T.any(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
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
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs,
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                      )
                    }
                  end

                class Logs < OpenAI::BaseModel
                  # The text output from the Code Interpreter tool call.
                  sig { returns(String) }
                  def logs
                  end

                  sig { params(_: String).returns(String) }
                  def logs=(_)
                  end

                  # Always `logs`.
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  # Text output from the Code Interpreter tool call as part of a run step.
                  sig { params(logs: String, type: Symbol).returns(T.attached_class) }
                  def self.new(logs:, type: :logs)
                  end

                  sig { override.returns({logs: String, type: Symbol}) }
                  def to_hash
                  end
                end

                class Image < OpenAI::BaseModel
                  sig do
                    returns(
                      OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image
                    )
                  end
                  def image
                  end

                  sig do
                    params(
                      _: T.any(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                        OpenAI::Util::AnyHash
                      )
                    )
                      .returns(
                        T.any(
                          OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                          OpenAI::Util::AnyHash
                        )
                      )
                  end
                  def image=(_)
                  end

                  # Always `image`.
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig do
                    params(
                      image: T.any(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                        OpenAI::Util::AnyHash
                      ),
                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(image:, type: :image)
                  end

                  sig do
                    override
                      .returns(
                        {
                          image: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
                          type: Symbol
                        }
                      )
                  end
                  def to_hash
                  end

                  class Image < OpenAI::BaseModel
                    # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                    #   image.
                    sig { returns(String) }
                    def file_id
                    end

                    sig { params(_: String).returns(String) }
                    def file_id=(_)
                    end

                    sig { params(file_id: String).returns(T.attached_class) }
                    def self.new(file_id:)
                    end

                    sig { override.returns({file_id: String}) }
                    def to_hash
                    end
                  end
                end

                class << self
                  sig do
                    override
                      .returns(
                        [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image]
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
