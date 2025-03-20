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
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
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
        params(key: String, type: Symbol, value: T.any(String, Float, T::Boolean)).returns(T.attached_class)
      end
      def self.new(key:, type:, value:)
      end

      sig { override.returns({key: String, type: Symbol, value: T.any(String, Float, T::Boolean)}) }
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
      class Type < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        EQ = :eq
        NE = :ne
        GT = :gt
        GTE = :gte
        LT = :lt
        LTE = :lte
      end

      # The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      class Value < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }
      end
    end
  end
end
