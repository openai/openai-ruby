# typed: strong

module OpenAI
  module Models
    class ResponseFormatJSONSchema < OpenAI::Internal::Type::BaseModel
      # Structured Outputs configuration options, including a JSON Schema.
      sig { returns(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema) }
      attr_reader :json_schema

      sig do
        params(
          json_schema: T.any(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, OpenAI::Internal::AnyHash)
        )
          .void
      end
      attr_writer :json_schema

      # The type of response format being defined. Always `json_schema`.
      sig { returns(Symbol) }
      attr_accessor :type

      # JSON Schema response format. Used to generate structured JSON responses. Learn
      # more about
      # [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
      sig do
        params(
          json_schema: T.any(OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, OpenAI::Internal::AnyHash),
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(json_schema:, type: :json_schema); end

      sig { override.returns({json_schema: OpenAI::Models::ResponseFormatJSONSchema::JSONSchema, type: Symbol}) }
      def to_hash; end

      class JSONSchema < OpenAI::Internal::Type::BaseModel
        # The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        # and dashes, with a maximum length of 64.
        sig { returns(String) }
        attr_accessor :name

        # A description of what the response format is for, used by the model to determine
        # how to respond in the format.
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # The schema for the response format, described as a JSON Schema object. Learn how
        # to build JSON schemas [here](https://json-schema.org/).
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        attr_reader :schema

        sig { params(schema: T::Hash[Symbol, T.anything]).void }
        attr_writer :schema

        # Whether to enable strict schema adherence when generating the output. If set to
        # true, the model will always follow the exact schema defined in the `schema`
        # field. Only a subset of JSON Schema is supported when `strict` is `true`. To
        # learn more, read the
        # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :strict

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
        def self.new(name:, description: nil, schema: nil, strict: nil); end

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
        def to_hash; end
      end
    end
  end
end
