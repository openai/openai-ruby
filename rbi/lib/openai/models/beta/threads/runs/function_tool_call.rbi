# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCall < OpenAI::BaseModel
            # The ID of the tool call object.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The definition of the function that was called.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function) }
            def function
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function)
                .returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function)
            end
            def function=(_)
            end

            # The type of tool call. This is always going to be `function` for this type of
            #   tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                id: String,
                function: OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, function:, type: :function)
            end

            sig do
              override
                .returns(
                  {id: String, function: OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function, type: Symbol}
                )
            end
            def to_hash
            end

            class Function < OpenAI::BaseModel
              # The arguments passed to the function.
              sig { returns(String) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

              # The name of the function.
              sig { returns(String) }
              def name
              end

              sig { params(_: String).returns(String) }
              def name=(_)
              end

              # The output of the function. This will be `null` if the outputs have not been
              #   [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
              #   yet.
              sig { returns(T.nilable(String)) }
              def output
              end

              sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
              def output=(_)
              end

              # The definition of the function that was called.
              sig do
                params(arguments: String, name: String, output: T.nilable(String)).returns(T.attached_class)
              end
              def self.new(arguments:, name:, output:)
              end

              sig { override.returns({arguments: String, name: String, output: T.nilable(String)}) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
