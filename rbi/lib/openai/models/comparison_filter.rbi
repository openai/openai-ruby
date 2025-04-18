# typed: strong

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::Internal::Type::BaseModel
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
      sig { returns(OpenAI::Models::ComparisonFilter::Type::OrSymbol) }
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
          type: OpenAI::Models::ComparisonFilter::Type::OrSymbol,
          value: T.any(String, Float, T::Boolean)
        )
          .returns(T.attached_class)
      end
      def self.new(key:, type:, value:); end

      sig do
        override
          .returns(
            {key: String, type: OpenAI::Models::ComparisonFilter::Type::OrSymbol, value: T.any(String, Float, T::Boolean)}
          )
      end
      def to_hash; end

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

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ComparisonFilter::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        EQ = T.let(:eq, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)
        NE = T.let(:ne, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)
        GT = T.let(:gt, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)
        GTE = T.let(:gte, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)
        LT = T.let(:lt, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)
        LTE = T.let(:lte, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ComparisonFilter::Type::TaggedSymbol]) }
        def self.values; end
      end

      # The value to compare against the attribute key; supports string, number, or
      # boolean types.
      module Value
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, Float, T::Boolean]) }
        def self.variants; end
      end
    end
  end
end
