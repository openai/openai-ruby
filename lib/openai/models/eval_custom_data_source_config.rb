# frozen_string_literal: true

module OpenAI
  module Models
    class EvalCustomDataSourceConfig < OpenAI::Internal::Type::BaseModel
      # @!attribute schema
      #   The json schema for the run data source items. Learn how to build JSON schemas
      #   [here](https://json-schema.org/).
      #
      #   @return [Hash{Symbol=>Object}]
      required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

      # @!attribute type
      #   The type of data source. Always `custom`.
      #
      #   @return [Symbol, :custom]
      required :type, const: :custom

      # @!method initialize(schema:, type: :custom)
      #   A CustomDataSourceConfig which specifies the schema of your `item` and
      #   optionally `sample` namespaces. The response schema defines the shape of the
      #   data that will be:
      #
      #   - Used to define your testing criteria and
      #   - What data is required when creating a run
      #
      #   @param schema [Hash{Symbol=>Object}]
      #   @param type [Symbol, :custom]
    end
  end
end
