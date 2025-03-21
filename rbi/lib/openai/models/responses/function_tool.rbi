# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::BaseModel
        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # A JSON schema object describing the parameters of the function.
        sig { returns(T::Hash[Symbol, T.anything]) }
        attr_accessor :parameters

        # Whether to enforce strict parameter validation. Default `true`.
        sig { returns(T::Boolean) }
        attr_accessor :strict

        # The type of the function tool. Always `function`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A description of the function. Used by the model to determine whether or not to
        #   call the function.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

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
