# typed: strong

module OpenAI
  module Models
    class EvalCustomDataSourceConfig < OpenAI::Internal::Type::BaseModel
      # The json schema for the run data source items. Learn how to build JSON schemas
      # [here](https://json-schema.org/).
      sig { returns(T::Hash[Symbol, T.anything]) }
      attr_accessor :schema

      # The type of data source. Always `custom`.
      sig { returns(Symbol) }
      attr_accessor :type

      # A CustomDataSourceConfig which specifies the schema of your `item` and
      # optionally `sample` namespaces. The response schema defines the shape of the
      # data that will be:
      #
      # - Used to define your testing criteria and
      # - What data is required when creating a run
      sig { params(schema: T::Hash[Symbol, T.anything], type: Symbol).returns(T.attached_class) }
      def self.new(
        # The json schema for the run data source items. Learn how to build JSON schemas
        # [here](https://json-schema.org/).
        schema:,
        # The type of data source. Always `custom`.
        type: :custom
      ); end
      sig { override.returns({schema: T::Hash[Symbol, T.anything], type: Symbol}) }
      def to_hash; end
    end
  end
end
