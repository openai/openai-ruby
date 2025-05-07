# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFormatTextJSONSchemaConfig < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        # and dashes, with a maximum length of 64.
        sig { returns(String) }
        attr_accessor :name

        # The schema for the response format, described as a JSON Schema object. Learn how
        # to build JSON schemas [here](https://json-schema.org/).
        sig { returns(T::Hash[Symbol, T.anything]) }
        attr_accessor :schema

        # The type of response format being defined. Always `json_schema`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A description of what the response format is for, used by the model to determine
        # how to respond in the format.
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # Whether to enable strict schema adherence when generating the output. If set to
        # true, the model will always follow the exact schema defined in the `schema`
        # field. Only a subset of JSON Schema is supported when `strict` is `true`. To
        # learn more, read the
        # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :strict

        # JSON Schema response format. Used to generate structured JSON responses. Learn
        # more about
        # [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
        sig do
          params(
            name: String,
            schema: T::Hash[Symbol, T.anything],
            description: String,
            strict: T.nilable(T::Boolean),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
          # and dashes, with a maximum length of 64.
          name:,
          # The schema for the response format, described as a JSON Schema object. Learn how
          # to build JSON schemas [here](https://json-schema.org/).
          schema:,
          # A description of what the response format is for, used by the model to determine
          # how to respond in the format.
          description: nil,
          # Whether to enable strict schema adherence when generating the output. If set to
          # true, the model will always follow the exact schema defined in the `schema`
          # field. Only a subset of JSON Schema is supported when `strict` is `true`. To
          # learn more, read the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          strict: nil,
          # The type of response format being defined. Always `json_schema`.
          type: :json_schema
        )
        end

        sig do
          override.returns(
            {
              name: String,
              schema: T::Hash[Symbol, T.anything],
              type: Symbol,
              description: String,
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
