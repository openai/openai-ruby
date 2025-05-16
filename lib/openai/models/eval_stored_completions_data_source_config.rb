# frozen_string_literal: true

module OpenAI
  module Models
    # @deprecated
    class EvalStoredCompletionsDataSourceConfig < OpenAI::Internal::Type::BaseModel
      # @!attribute schema
      #   The json schema for the run data source items. Learn how to build JSON schemas
      #   [here](https://json-schema.org/).
      #
      #   @return [Hash{Symbol=>Object}]
      required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

      # @!attribute type
      #   The type of data source. Always `stored-completions`.
      #
      #   @return [Symbol, :"stored-completions"]
      required :type, const: :"stored-completions"

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!method initialize(schema:, metadata: nil, type: :"stored-completions")
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::EvalStoredCompletionsDataSourceConfig} for more details.
      #
      #   Deprecated in favor of LogsDataSourceConfig.
      #
      #   @param schema [Hash{Symbol=>Object}] The json schema for the run data source items.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param type [Symbol, :"stored-completions"] The type of data source. Always `stored-completions`.
    end
  end
end
