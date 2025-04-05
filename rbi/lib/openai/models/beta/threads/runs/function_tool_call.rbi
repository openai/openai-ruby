# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCall < OpenAI::Internal::Type::BaseModel
            # The ID of the tool call object.
            sig { returns(String) }
            attr_accessor :id

            # The definition of the function that was called.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function) }
            attr_reader :function

            sig do
              params(
                function: T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function, OpenAI::Internal::AnyHash)
              )
                .void
            end
            attr_writer :function

            # The type of tool call. This is always going to be `function` for this type of
            # tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                id: String,
                function: T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function, OpenAI::Internal::AnyHash),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, function:, type: :function); end

            sig do
              override
                .returns(
                  {id: String, function: OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function, type: Symbol}
                )
            end
            def to_hash; end

            class Function < OpenAI::Internal::Type::BaseModel
              # The arguments passed to the function.
              sig { returns(String) }
              attr_accessor :arguments

              # The name of the function.
              sig { returns(String) }
              attr_accessor :name

              # The output of the function. This will be `null` if the outputs have not been
              # [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
              # yet.
              sig { returns(T.nilable(String)) }
              attr_accessor :output

              # The definition of the function that was called.
              sig do
                params(arguments: String, name: String, output: T.nilable(String)).returns(T.attached_class)
              end
              def self.new(arguments:, name:, output:); end

              sig { override.returns({arguments: String, name: String, output: T.nilable(String)}) }
              def to_hash; end
            end
          end
        end
      end
    end
  end
end
