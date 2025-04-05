# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFormatTextJSONSchemaConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores
        #   and dashes, with a maximum length of 64.
        #
        #   @return [String]
        required :name, String

        # @!attribute schema
        #   The schema for the response format, described as a JSON Schema object. Learn how
        #   to build JSON schemas [here](https://json-schema.org/).
        #
        #   @return [Hash{Symbol=>Object}]
        required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

        # @!attribute type
        #   The type of response format being defined. Always `json_schema`.
        #
        #   @return [Symbol, :json_schema]
        required :type, const: :json_schema

        # @!attribute [r] description
        #   A description of what the response format is for, used by the model to determine
        #   how to respond in the format.
        #
        #   @return [String, nil]
        optional :description, String

        # @!parse
        #   # @return [String]
        #   attr_writer :description

        # @!attribute strict
        #   Whether to enable strict schema adherence when generating the output. If set to
        #   true, the model will always follow the exact schema defined in the `schema`
        #   field. Only a subset of JSON Schema is supported when `strict` is `true`. To
        #   learn more, read the
        #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #   @return [Boolean, nil]
        optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

        # @!parse
        #   # JSON Schema response format. Used to generate structured JSON responses. Learn
        #   # more about
        #   # [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
        #   #
        #   # @param name [String]
        #   # @param schema [Hash{Symbol=>Object}]
        #   # @param description [String]
        #   # @param strict [Boolean, nil]
        #   # @param type [Symbol, :json_schema]
        #   #
        #   def initialize(name:, schema:, description: nil, strict: nil, type: :json_schema, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
