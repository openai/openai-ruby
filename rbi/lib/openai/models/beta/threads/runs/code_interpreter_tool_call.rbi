# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCall < OpenAI::BaseModel
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter) }
            def code_interpreter
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter)
                .returns(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter)
            end
            def code_interpreter=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                id: String,
                code_interpreter: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter,
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
              sig { returns(String) }
              def input
              end

              sig { params(_: String).returns(String) }
              def input=(_)
              end

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

              class Output < OpenAI::Union
                abstract!

                class Logs < OpenAI::BaseModel
                  sig { returns(String) }
                  def logs
                  end

                  sig { params(_: String).returns(String) }
                  def logs=(_)
                  end

                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

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
                      _: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image
                    )
                      .returns(
                        OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image
                      )
                  end
                  def image=(_)
                  end

                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig do
                    params(
                      image: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image,
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
                        [[Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs], [Symbol, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image]]
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
