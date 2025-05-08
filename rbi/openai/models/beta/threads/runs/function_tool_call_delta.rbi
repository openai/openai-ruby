# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCallDelta < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of tool call. This is always going to be `function` for this type of
            # tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            # The ID of the tool call object.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The definition of the function that was called.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::FunctionToolCallDelta::Function
                )
              )
            end
            attr_reader :function

            sig do
              params(
                function:
                  OpenAI::Beta::Threads::Runs::FunctionToolCallDelta::Function::OrHash
              ).void
            end
            attr_writer :function

            sig do
              params(
                index: Integer,
                id: String,
                function:
                  OpenAI::Beta::Threads::Runs::FunctionToolCallDelta::Function::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The index of the tool call in the tool calls array.
              index:,
              # The ID of the tool call object.
              id: nil,
              # The definition of the function that was called.
              function: nil,
              # The type of tool call. This is always going to be `function` for this type of
              # tool call.
              type: :function
            )
            end

            sig do
              override.returns(
                {
                  index: Integer,
                  type: Symbol,
                  id: String,
                  function:
                    OpenAI::Beta::Threads::Runs::FunctionToolCallDelta::Function
                }
              )
            end
            def to_hash
            end

            class Function < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

              # The arguments passed to the function.
              sig { returns(T.nilable(String)) }
              attr_reader :arguments

              sig { params(arguments: String).void }
              attr_writer :arguments

              # The name of the function.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

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
                arguments: nil,
                # The name of the function.
                name: nil,
                # The output of the function. This will be `null` if the outputs have not been
                # [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
                # yet.
                output: nil
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
