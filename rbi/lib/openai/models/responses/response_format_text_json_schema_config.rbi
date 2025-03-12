# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFormatTextJSONSchemaConfig < OpenAI::BaseModel
        sig { returns(T::Hash[Symbol, T.anything]) }
        def schema
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def schema=(_)
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

        sig { params(_: String).returns(String) }
        def description=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def strict
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def strict=(_)
        end

        sig do
          params(
            schema: T::Hash[Symbol, T.anything],
            description: String,
            name: String,
            strict: T.nilable(T::Boolean),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(schema:, description: nil, name: nil, strict: nil, type: :json_schema)
        end

        sig do
          override
            .returns(
              {
                schema: T::Hash[Symbol, T.anything],
                type: Symbol,
                description: String,
                name: String,
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
