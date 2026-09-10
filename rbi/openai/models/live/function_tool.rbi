# typed: strong

module OpenAI
  module Models

    module Live

      class FunctionTool < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::FunctionTool,
            OpenAI::Internal::AnyHash
          )
        end

        # The name the delegated Responses model uses when calling this function.
        sig { returns(String) }
        attr_accessor :name

        # The tool type. Always `function`.
        sig { returns(Symbol) }
        attr_accessor :type

        # What the function does and when the delegated Responses model should call it.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # A JSON Schema object describing the arguments accepted by the function.
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        attr_accessor :parameters

        # Whether the delegated Responses model must follow the function’s parameter
        # schema exactly.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :strict

        # A function tool available to the Responses backend when the Live model delegates
        # a task.
        sig do
          params(

            name: String,

            description: T.nilable(String),

            parameters: T.nilable(T::Hash[Symbol, T.anything]),

            strict: T.nilable(T::Boolean),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The name the delegated Responses model uses when calling this function.
          name:,

          # What the function does and when the delegated Responses model should call it.
          description: nil,

          # A JSON Schema object describing the arguments accepted by the function.
          parameters: nil,

          # Whether the delegated Responses model must follow the function’s parameter
          # schema exactly.
          strict: nil,

          # The tool type. Always `function`.

          type: :function
        )
        end

        sig do
          override.returns(
            {
              name: String,
              type: Symbol,
              description: T.nilable(String),
              parameters: T.nilable(T::Hash[Symbol, T.anything]),
              strict: T.nilable(T::Boolean)
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
