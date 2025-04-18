# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatJSONSchema < OpenAI::Internal::Type::BaseModel
      # @!attribute json_schema
      #   Structured Outputs configuration options, including a JSON Schema.
      #
      #   @return [OpenAI::Models::ResponseFormatJSONSchema::JSONSchema]
      required :json_schema, -> { OpenAI::Models::ResponseFormatJSONSchema::JSONSchema }

      # @!attribute type
      #   The type of response format being defined. Always `json_schema`.
      #
      #   @return [Symbol, :json_schema]
      required :type, const: :json_schema

      # @!method initialize(json_schema:, type: :json_schema)
      #   JSON Schema response format. Used to generate structured JSON responses. Learn
      #   more about
      #   [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
      #
      #   @param json_schema [OpenAI::Models::ResponseFormatJSONSchema::JSONSchema]
      #   @param type [Symbol, :json_schema]

      # @see OpenAI::Models::ResponseFormatJSONSchema#json_schema
      class JSONSchema < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        #   and dashes, with a maximum length of 64.
        #
        #   @return [String]
        required :name, String

        # @!attribute description
        #   A description of what the response format is for, used by the model to determine
        #   how to respond in the format.
        #
        #   @return [String, nil]
        optional :description, String

        # @!attribute schema
        #   The schema for the response format, described as a JSON Schema object. Learn how
        #   to build JSON schemas [here](https://json-schema.org/).
        #
        #   @return [Hash{Symbol=>Object}, nil]
        optional :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

        # @!attribute strict
        #   Whether to enable strict schema adherence when generating the output. If set to
        #   true, the model will always follow the exact schema defined in the `schema`
        #   field. Only a subset of JSON Schema is supported when `strict` is `true`. To
        #   learn more, read the
        #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #   @return [Boolean, nil]
        optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

        # @!method initialize(name:, description: nil, schema: nil, strict: nil)
        #   Structured Outputs configuration options, including a JSON Schema.
        #
        #   @param name [String]
        #   @param description [String]
        #   @param schema [Hash{Symbol=>Object}]
        #   @param strict [Boolean, nil]
      end
    end
  end
end
