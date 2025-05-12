# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::FunctionTool, OpenAI::Internal::AnyHash)
          end

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # A JSON schema object describing the parameters of the function.
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        attr_accessor :parameters

        # Whether to enforce strict parameter validation. Default `true`.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :strict

        # The type of the function tool. Always `function`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A description of the function. Used by the model to determine whether or not to
        # call the function.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # Defines a function in your own code the model can choose to call. Learn more
        # about
        # [function calling](https://platform.openai.com/docs/guides/function-calling).
        sig do
          params(
            name: String,
            parameters: T.nilable(T::Hash[Symbol, T.anything]),
            strict: T.nilable(T::Boolean),
            description: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the function to call.
          name:,
          # A JSON schema object describing the parameters of the function.
          parameters:,
          # Whether to enforce strict parameter validation. Default `true`.
          strict:,
          # A description of the function. Used by the model to determine whether or not to
          # call the function.
          description: nil,
          # The type of the function tool. Always `function`.
          type: :function
        )
        end

        sig do
          override.returns(
            {
              name: String,
              parameters: T.nilable(T::Hash[Symbol, T.anything]),
              strict: T.nilable(T::Boolean),
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
