# typed: strong

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::BaseModel
      # The key to compare against the value.
      sig { returns(String) }
      def key
      end

      sig { params(_: String).returns(String) }
      def key=(_)
      end

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      #   - `eq`: equals
      #   - `ne`: not equal
      #   - `gt`: greater than
      #   - `gte`: greater than or equal
      #   - `lt`: less than
      #   - `lte`: less than or equal
      sig { returns(OpenAI::Models::ComparisonFilter::Type::OrSymbol) }
      def type
      end

      sig do
        params(_: OpenAI::Models::ComparisonFilter::Type::OrSymbol)
          .returns(OpenAI::Models::ComparisonFilter::Type::OrSymbol)
      end
      def type=(_)
      end

      # The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      sig { returns(T.any(String, Float, T::Boolean)) }
      def value
      end

      sig { params(_: T.any(String, Float, T::Boolean)).returns(T.any(String, Float, T::Boolean)) }
      def value=(_)
      end

      # A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      sig do
        params(
          key: String,
          type: OpenAI::Models::ComparisonFilter::Type::OrSymbol,
          value: T.any(String, Float, T::Boolean)
        )
          .returns(T.attached_class)
      end
      def self.new(key:, type:, value:)
      end

      sig do
        override
          .returns(
            {key: String, type: OpenAI::Models::ComparisonFilter::Type::OrSymbol, value: T.any(String, Float, T::Boolean)}
          )
      end
      def to_hash
      end

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      #   - `eq`: equals
      #   - `ne`: not equal
      #   - `gt`: greater than
      #   - `gte`: greater than or equal
      #   - `lt`: less than
      #   - `lte`: less than or equal
      module Type
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ComparisonFilter::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ComparisonFilter::Type::TaggedSymbol) }

        EQ = T.let(:eq, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
        NE = T.let(:ne, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
        GT = T.let(:gt, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
        GTE = T.let(:gte, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
        LT = T.let(:lt, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
        LTE = T.let(:lte, OpenAI::Models::ComparisonFilter::Type::OrSymbol)
      end

      # The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      module Value
        extend OpenAI::Union

        Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }
      end
    end
  end
end
