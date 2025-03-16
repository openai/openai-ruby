# typed: strong

module OpenAI
  module Models
    class CompoundFilter < OpenAI::BaseModel
      # Array of filters to combine. Items can be `ComparisonFilter` or
      #   `CompoundFilter`.
      sig { returns(T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)]) }
      def filters
      end

      sig do
        params(_: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)])
          .returns(T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)])
      end
      def filters=(_)
      end

      # Type of operation: `and` or `or`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # Combine multiple filters using `and` or `or`.
      sig do
        params(filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)], type: Symbol)
          .returns(T.attached_class)
      end
      def self.new(filters:, type:)
      end

      sig { override.returns({filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)], type: Symbol}) }
      def to_hash
      end

      # A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      class Filter < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(OpenAI::Models::ComparisonFilter, T.anything)} }
      end

      # Type of operation: `and` or `or`.
      class Type < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        AND = :and
        OR = :or
      end
    end
  end
end
