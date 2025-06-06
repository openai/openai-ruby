# typed: strong

module OpenAI
  module Models
    class EvalCustomDataSourceConfig < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::EvalCustomDataSourceConfig, OpenAI::Internal::AnyHash)
        end

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
      sig do
        params(schema: T::Hash[Symbol, T.anything], type: Symbol).returns(
          T.attached_class
        )
      end
      def self.new(
        # The json schema for the run data source items. Learn how to build JSON schemas
        # [here](https://json-schema.org/).
        schema:,
        # The type of data source. Always `custom`.
        type: :custom
      )
      end

      sig do
        override.returns({ schema: T::Hash[Symbol, T.anything], type: Symbol })
      end
      def to_hash
      end
    end
  end
end
