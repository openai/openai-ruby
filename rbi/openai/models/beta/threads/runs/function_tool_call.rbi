# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCall < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::FunctionToolCall,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the tool call object.
            sig { returns(String) }
            attr_accessor :id

            # The definition of the function that was called.
            sig do
              returns(OpenAI::Beta::Threads::Runs::FunctionToolCall::Function)
            end
            attr_reader :function

            sig do
              params(
                function:
                  OpenAI::Beta::Threads::Runs::FunctionToolCall::Function::OrHash
              ).void
            end
            attr_writer :function

            # The type of tool call. This is always going to be `function` for this type of
            # tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                id: String,
                function:
                  OpenAI::Beta::Threads::Runs::FunctionToolCall::Function::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the tool call object.
              id:,
              # The definition of the function that was called.
              function:,
              # The type of tool call. This is always going to be `function` for this type of
              # tool call.
              type: :function
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  function:
                    OpenAI::Beta::Threads::Runs::FunctionToolCall::Function,
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class Function < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::FunctionToolCall::Function,
                    OpenAI::Internal::AnyHash
                  )
                end

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
                params(
                  arguments: String,
                  name: String,
                  output: T.nilable(String)
                ).returns(T.attached_class)
              end
              def self.new(
                # The arguments passed to the function.
                arguments:,
                # The name of the function.
                name:,
                # The output of the function. This will be `null` if the outputs have not been
                # [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
                # yet.
                output:
              )
              end

              sig do
                override.returns(
                  { arguments: String, name: String, output: T.nilable(String) }
                )
              end
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
