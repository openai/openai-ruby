# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCallDelta < OpenAI::BaseModel
            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # The type of tool call. This is always going to be `function` for this type of
            #   tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The ID of the tool call object.
            sig { returns(T.nilable(String)) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The definition of the function that was called.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function)) }
            def function
            end

            sig do
              params(
                _: T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, OpenAI::Util::AnyHash)
              )
                .returns(
                  T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, OpenAI::Util::AnyHash)
                )
            end
            def function=(_)
            end

            sig do
              params(
                index: Integer,
                id: String,
                function: OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(index:, id: nil, function: nil, type: :function)
            end

            sig do
              override
                .returns(
                  {
                    index: Integer,
                    type: Symbol,
                    id: String,
                    function: OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function
                  }
                )
            end
            def to_hash
            end

            class Function < OpenAI::BaseModel
              # The arguments passed to the function.
              sig { returns(T.nilable(String)) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

              # The name of the function.
              sig { returns(T.nilable(String)) }
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
              def self.new(arguments: nil, name: nil, output: nil)
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
