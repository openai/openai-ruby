# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFormatTextJSONSchemaConfig < OpenAI::BaseModel
        # The schema for the response format, described as a JSON Schema object. Learn how
        #   to build JSON schemas [here](https://json-schema.org/).
        sig { returns(T::Hash[Symbol, T.anything]) }
        def schema
        end

        sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
        def schema=(_)
        end

        # The type of response format being defined. Always `json_schema`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A description of what the response format is for, used by the model to determine
        #   how to respond in the format.
        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: String).returns(String) }
        def description=(_)
        end

        # The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        #   and dashes, with a maximum length of 64.
        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
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

        # JSON Schema response format. Used to generate structured JSON responses. Learn
        #   more about
        #   [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
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
