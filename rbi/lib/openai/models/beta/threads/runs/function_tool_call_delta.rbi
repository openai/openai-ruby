# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCallDelta < OpenAI::BaseModel
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

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function)) }
            def function
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function)
                .returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function)
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
              sig { returns(T.nilable(String)) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

              sig { returns(T.nilable(String)) }
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
