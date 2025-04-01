# typed: strong

module OpenAI
  module Models
    class CompoundFilter < OpenAI::BaseModel
      # Array of filters to combine. Items can be `ComparisonFilter` or
      #   `CompoundFilter`.
      sig { returns(T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)]) }
      attr_accessor :filters

      # Type of operation: `and` or `or`.
      sig { returns(OpenAI::Models::CompoundFilter::Type::OrSymbol) }
      attr_accessor :type

      # Combine multiple filters using `and` or `or`.
      sig do
        params(
          filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, OpenAI::Util::AnyHash, T.anything)],
          type: OpenAI::Models::CompoundFilter::Type::OrSymbol
        )
          .returns(T.attached_class)
      end
      def self.new(filters:, type:)
      end

      sig do
        override
          .returns(
            {
              filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)],
              type: OpenAI::Models::CompoundFilter::Type::OrSymbol
            }
          )
      end
      def to_hash
      end

      # A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      module Filter
        extend OpenAI::Union

        sig { override.returns([OpenAI::Models::ComparisonFilter, T.anything]) }
        def self.variants
        end
      end

      # Type of operation: `and` or `or`.
      module Type
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::CompoundFilter::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::CompoundFilter::Type::TaggedSymbol) }

        AND = T.let(:and, OpenAI::Models::CompoundFilter::Type::TaggedSymbol)
        OR = T.let(:or, OpenAI::Models::CompoundFilter::Type::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::CompoundFilter::Type::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
