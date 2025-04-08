# frozen_string_literal: true

module OpenAI
  module Models
    class EvalStoredCompletionsDataSourceConfig < OpenAI::Internal::Type::BaseModel
      # @!attribute schema
      #   The json schema for the run data source items. Learn how to build JSON schemas
      #   [here](https://json-schema.org/).
      #
      #   @return [Hash{Symbol=>Object}]
      required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

      # @!attribute type
      #   The type of data source. Always `stored_completions`.
      #
      #   @return [Symbol, :stored_completions]
      required :type, const: :stored_completions

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

      # @!parse
      #   # A StoredCompletionsDataSourceConfig which specifies the metadata property of
      #   # your stored completions query. This is usually metadata like `usecase=chatbot`
      #   # or `prompt-version=v2`, etc. The schema returned by this data source config is
      #   # used to defined what variables are available in your evals. `item` and `sample`
      #   # are both defined when using this data source config.
      #   #
      #   # @param schema [Hash{Symbol=>Object}]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param type [Symbol, :stored_completions]
      #   #
      #   def initialize(schema:, metadata: nil, type: :stored_completions, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
