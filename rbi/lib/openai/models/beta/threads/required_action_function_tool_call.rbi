# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RequiredActionFunctionToolCall < OpenAI::BaseModel
          # The ID of the tool call. This ID must be referenced when you submit the tool
          #   outputs in using the
          #   [Submit tool outputs to run](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
          #   endpoint.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The function definition.
          sig { returns(OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function) }
          def function
          end

          sig do
            params(
              _: T.any(OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function, OpenAI::Util::AnyHash)
            )
              .returns(
                T.any(OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function, OpenAI::Util::AnyHash)
              )
          end
          def function=(_)
          end

          # The type of tool call the output is required for. For now, this is always
          #   `function`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # Tool call objects
          sig do
            params(
              id: String,
              function: T.any(OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function, OpenAI::Util::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(id:, function:, type: :function)
          end

          sig do
            override
              .returns(
                {id: String, function: OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function, type: Symbol}
              )
          end
          def to_hash
          end

          class Function < OpenAI::BaseModel
            # The arguments that the model expects you to pass to the function.
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

            # The function definition.
            sig { params(arguments: String, name: String).returns(T.attached_class) }
            def self.new(arguments:, name:)
            end

            sig { override.returns({arguments: String, name: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
