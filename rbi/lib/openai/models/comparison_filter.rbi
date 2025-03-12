# typed: strong

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::BaseModel
      sig { returns(String) }
      def key
      end

      sig { params(_: String).returns(String) }
      def key=(_)
      end

      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      sig { returns(T.any(String, Float, T::Boolean)) }
      def value
      end

      sig { params(_: T.any(String, Float, T::Boolean)).returns(T.any(String, Float, T::Boolean)) }
      def value=(_)
      end

      sig do
        params(key: String, type: Symbol, value: T.any(String, Float, T::Boolean)).returns(T.attached_class)
      end
      def self.new(key:, type:, value:)
      end

      sig { override.returns({key: String, type: Symbol, value: T.any(String, Float, T::Boolean)}) }
      def to_hash
      end

      class Type < OpenAI::Enum
        abstract!

        EQ = :eq
        NE = :ne
        GT = :gt
        GTE = :gte
        LT = :lt
        LTE = :lte

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end

      class Value < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
          private def variants
          end
        end
      end
    end
  end
end
