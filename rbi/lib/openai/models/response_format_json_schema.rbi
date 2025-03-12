# typed: strong

module OpenAI
  module Models
    class ResponseFormatJSONSchema < OpenAI::BaseModel
      sig { returns(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema) }
      def json_schema
      end

      sig do
        params(_: OpenAI::Models::ResponseFormatJSONSchema::JSONSchema)
          .returns(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema)
      end
      def json_schema=(_)
      end

      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      sig do
        params(json_schema: OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, type: Symbol)
          .returns(T.attached_class)
      end
      def self.new(json_schema:, type: :json_schema)
      end

      sig { override.returns({json_schema: OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, type: Symbol}) }
      def to_hash
      end

      class JSONSchema < OpenAI::BaseModel
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: String).returns(String) }
        def description=(_)
        end

        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        def schema
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def schema=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def strict
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def strict=(_)
        end

        sig do
          params(
            name: String,
            description: String,
            schema: T::Hash[Symbol, T.anything],
            strict: T.nilable(T::Boolean)
          )
            .returns(T.attached_class)
        end
        def self.new(name:, description: nil, schema: nil, strict: nil)
        end

        sig do
          override
            .returns(
              {
                name: String,
                description: String,
                schema: T::Hash[Symbol, T.anything],
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
