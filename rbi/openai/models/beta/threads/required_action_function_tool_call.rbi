# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RequiredActionFunctionToolCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::RequiredActionFunctionToolCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the tool call. This ID must be referenced when you submit the tool
          # outputs in using the
          # [Submit tool outputs to run](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
          # endpoint.
          sig { returns(String) }
          attr_accessor :id

          # The function definition.
          sig do
            returns(
              OpenAI::Beta::Threads::RequiredActionFunctionToolCall::Function
            )
          end
          attr_reader :function

          sig do
            params(
              function:
                OpenAI::Beta::Threads::RequiredActionFunctionToolCall::Function::OrHash
            ).void
          end
          attr_writer :function

          # The type of tool call the output is required for. For now, this is always
          # `function`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Tool call objects
          sig do
            params(
              id: String,
              function:
                OpenAI::Beta::Threads::RequiredActionFunctionToolCall::Function::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the tool call. This ID must be referenced when you submit the tool
            # outputs in using the
            # [Submit tool outputs to run](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
            # endpoint.
            id:,
            # The function definition.
            function:,
            # The type of tool call the output is required for. For now, this is always
            # `function`.
            type: :function
          )
          end

          sig do
            override.returns(
              {
                id: String,
                function:
                  OpenAI::Beta::Threads::RequiredActionFunctionToolCall::Function,
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
                  OpenAI::Beta::Threads::RequiredActionFunctionToolCall::Function,
                  OpenAI::Internal::AnyHash
                )
              end

            # The arguments that the model expects you to pass to the function.
            sig { returns(String) }
            attr_accessor :arguments

            # The name of the function.
            sig { returns(String) }
            attr_accessor :name

            # The function definition.
            sig do
              params(arguments: String, name: String).returns(T.attached_class)
            end
            def self.new(
              # The arguments that the model expects you to pass to the function.
              arguments:,
              # The name of the function.
              name:
            )
            end

            sig { override.returns({ arguments: String, name: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
