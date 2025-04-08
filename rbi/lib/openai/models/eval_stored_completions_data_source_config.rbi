# typed: strong

module OpenAI
  module Models
    class EvalStoredCompletionsDataSourceConfig < OpenAI::Internal::Type::BaseModel
      # The json schema for the run data source items. Learn how to build JSON schemas
      # [here](https://json-schema.org/).
      sig { returns(T::Hash[Symbol, T.anything]) }
      attr_accessor :schema

      # The type of data source. Always `stored_completions`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # A StoredCompletionsDataSourceConfig which specifies the metadata property of
      # your stored completions query. This is usually metadata like `usecase=chatbot`
      # or `prompt-version=v2`, etc. The schema returned by this data source config is
      # used to defined what variables are available in your evals. `item` and `sample`
      # are both defined when using this data source config.
      sig do
        params(
          schema: T::Hash[Symbol, T.anything],
          metadata: T.nilable(T::Hash[Symbol, String]),
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(schema:, metadata: nil, type: :stored_completions); end

      sig do
        override
          .returns({
                     schema: T::Hash[Symbol, T.anything],
                     type: Symbol,
                     metadata: T.nilable(T::Hash[Symbol, String])
                   })
      end
      def to_hash; end
    end
  end
end
