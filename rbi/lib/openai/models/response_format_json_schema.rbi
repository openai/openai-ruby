# typed: strong

module OpenAI
  module Models
    class ResponseFormatJSONSchema < OpenAI::BaseModel
      # Structured Outputs configuration options, including a JSON Schema.
      sig { returns(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema) }
      def json_schema
      end

      sig do
        params(_: T.any(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, OpenAI::Util::AnyHash))
          .returns(T.any(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, OpenAI::Util::AnyHash))
      end
      def json_schema=(_)
      end

      # The type of response format being defined. Always `json_schema`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # JSON Schema response format. Used to generate structured JSON responses. Learn
      #   more about
      #   [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
      sig do
        params(
          json_schema: T.any(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, OpenAI::Util::AnyHash),
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(json_schema:, type: :json_schema)
      end

      sig { override.returns({json_schema: OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, type: Symbol}) }
      def to_hash
      end

      class JSONSchema < OpenAI::BaseModel
        # The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        #   and dashes, with a maximum length of 64.
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # A description of what the response format is for, used by the model to determine
        #   how to respond in the format.
        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: String).returns(String) }
        def description=(_)
        end

        # The schema for the response format, described as a JSON Schema object. Learn how
        #   to build JSON schemas [here](https://json-schema.org/).
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        def schema
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def schema=(_)
        end

        # Whether to enable strict schema adherence when generating the output. If set to
        #   true, the model will always follow the exact schema defined in the `schema`
        #   field. Only a subset of JSON Schema is supported when `strict` is `true`. To
        #   learn more, read the
        #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        sig { returns(T.nilable(T::Boolean)) }
        def strict
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def strict=(_)
        end

        # Structured Outputs configuration options, including a JSON Schema.
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
