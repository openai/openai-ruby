# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCallDelta < OpenAI::Internal::Type::BaseModel
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
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function)) }
            attr_reader :function

            sig do
              params(
                function: T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, OpenAI::Internal::AnyHash)
              )
                .void
            end
            attr_writer :function

            sig do
              params(
                index: Integer,
                id: String,
                function: T.any(OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, OpenAI::Internal::AnyHash),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(index:, id: nil, function: nil, type: :function); end

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
            def to_hash; end

            class Function < OpenAI::Internal::Type::BaseModel
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
                params(arguments: String, name: String, output: T.nilable(String)).returns(T.attached_class)
              end
              def self.new(arguments: nil, name: nil, output: nil); end

              sig { override.returns({arguments: String, name: String, output: T.nilable(String)}) }
              def to_hash; end
            end
          end
        end
      end
    end
  end
end
