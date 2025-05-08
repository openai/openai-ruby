# typed: strong

module OpenAI
  module Models
    class CompoundFilter < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # Array of filters to combine. Items can be `ComparisonFilter` or
      # `CompoundFilter`.
      sig { returns(T::Array[T.any(OpenAI::ComparisonFilter, T.anything)]) }
      attr_accessor :filters

      # Type of operation: `and` or `or`.
      sig { returns(OpenAI::CompoundFilter::Type::OrSymbol) }
      attr_accessor :type

      # Combine multiple filters using `and` or `or`.
      sig do
        params(
          filters:
            T::Array[T.any(OpenAI::ComparisonFilter::OrHash, T.anything)],
          type: OpenAI::CompoundFilter::Type::OrSymbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Array of filters to combine. Items can be `ComparisonFilter` or
        # `CompoundFilter`.
        filters:,
        # Type of operation: `and` or `or`.
        type:
      )
      end

      sig do
        override.returns(
          {
            filters: T::Array[T.any(OpenAI::ComparisonFilter, T.anything)],
            type: OpenAI::CompoundFilter::Type::OrSymbol
          }
        )
      end
      def to_hash
      end

      # A filter used to compare a specified attribute key to a given value using a
      # defined comparison operation.
      module Filter
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(OpenAI::ComparisonFilter, T.anything) }

        sig do
          override.returns(T::Array[OpenAI::CompoundFilter::Filter::Variants])
        end
        def self.variants
        end
      end

      # Type of operation: `and` or `or`.
      module Type
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::CompoundFilter::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AND = T.let(:and, OpenAI::CompoundFilter::Type::TaggedSymbol)
        OR = T.let(:or, OpenAI::CompoundFilter::Type::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::CompoundFilter::Type::TaggedSymbol])
        end
        def self.values
        end
      end
    end
  end
end
