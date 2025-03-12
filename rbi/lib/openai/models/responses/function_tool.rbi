# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::BaseModel
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { returns(T::Hash[Symbol, T.anything]) }
        def parameters
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def parameters=(_)
        end

        sig { returns(T::Boolean) }
        def strict
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def strict=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_)
        end

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
