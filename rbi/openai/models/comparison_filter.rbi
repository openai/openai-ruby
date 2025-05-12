# typed: strong

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ComparisonFilter, OpenAI::Internal::AnyHash)
        end

      # The key to compare against the value.
      sig { returns(String) }
      attr_accessor :key

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      # - `eq`: equals
      # - `ne`: not equal
      # - `gt`: greater than
      # - `gte`: greater than or equal
      # - `lt`: less than
      # - `lte`: less than or equal
      sig { returns(OpenAI::ComparisonFilter::Type::OrSymbol) }
      attr_accessor :type

      # The value to compare against the attribute key; supports string, number, or
      # boolean types.
      sig { returns(T.any(String, Float, T::Boolean)) }
      attr_accessor :value

      # A filter used to compare a specified attribute key to a given value using a
      # defined comparison operation.
      sig do
        params(
          key: String,
          type: OpenAI::ComparisonFilter::Type::OrSymbol,
          value: T.any(String, Float, T::Boolean)
        ).returns(T.attached_class)
      end
      def self.new(
        # The key to compare against the value.
        key:,
        # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
        #
        # - `eq`: equals
        # - `ne`: not equal
        # - `gt`: greater than
        # - `gte`: greater than or equal
        # - `lt`: less than
        # - `lte`: less than or equal
        type:,
        # The value to compare against the attribute key; supports string, number, or
        # boolean types.
        value:
      )
      end

      sig do
        override.returns(
          {
            key: String,
            type: OpenAI::ComparisonFilter::Type::OrSymbol,
            value: T.any(String, Float, T::Boolean)
          }
        )
      end
      def to_hash
      end

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      # - `eq`: equals
      # - `ne`: not equal
      # - `gt`: greater than
      # - `gte`: greater than or equal
      # - `lt`: less than
      # - `lte`: less than or equal
      module Type
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ComparisonFilter::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        EQ = T.let(:eq, OpenAI::ComparisonFilter::Type::TaggedSymbol)
        NE = T.let(:ne, OpenAI::ComparisonFilter::Type::TaggedSymbol)
        GT = T.let(:gt, OpenAI::ComparisonFilter::Type::TaggedSymbol)
        GTE = T.let(:gte, OpenAI::ComparisonFilter::Type::TaggedSymbol)
        LT = T.let(:lt, OpenAI::ComparisonFilter::Type::TaggedSymbol)
        LTE = T.let(:lte, OpenAI::ComparisonFilter::Type::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ComparisonFilter::Type::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The value to compare against the attribute key; supports string, number, or
      # boolean types.
      module Value
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, Float, T::Boolean) }

        sig do
          override.returns(T::Array[OpenAI::ComparisonFilter::Value::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
