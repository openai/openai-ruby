# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::BaseModel
        # The name of the function to call.
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # A JSON schema object describing the parameters of the function.
        sig { returns(T::Hash[Symbol, T.anything]) }
        def parameters
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def parameters=(_)
        end

        # Whether to enforce strict parameter validation. Default `true`.
        sig { returns(T::Boolean) }
        def strict
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def strict=(_)
        end

        # The type of the function tool. Always `function`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A description of the function. Used by the model to determine whether or not to
        #   call the function.
        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_)
        end

        # Defines a function in your own code the model can choose to call. Learn more
        #   about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        sig do
          params(
            name: String,
            parameters: T::Hash[Symbol, T.anything],
            strict: T::Boolean,
            description: T.nilable(String),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(name:, parameters:, strict:, description: nil, type: :function)
        end

        sig do
          override
            .returns(
              {
                name: String,
                parameters: T::Hash[Symbol, T.anything],
                strict: T::Boolean,
                type: Symbol,
                description: T.nilable(String)
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
