# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCall < OpenAI::BaseModel
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function) }
            def function
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function)
                .returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function)
            end
            def function=(_)
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
              sig { returns(String) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

              sig { returns(String) }
              def name
              end

              sig { params(_: String).returns(String) }
              def name=(_)
              end

              sig { returns(T.nilable(String)) }
              def output
              end

              sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
              def output=(_)
              end

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
