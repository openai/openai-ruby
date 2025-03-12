# typed: strong

module OpenAI
  module Models
    class CompoundFilter < OpenAI::BaseModel
      sig { returns(T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)]) }
      def filters
      end

      sig do
        params(_: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)])
          .returns(T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)])
      end
      def filters=(_)
      end

      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      sig do
        params(filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)], type: Symbol)
          .returns(T.attached_class)
      end
      def self.new(filters:, type:)
      end

      sig { override.returns({filters: T::Array[T.any(OpenAI::Models::ComparisonFilter, T.anything)], type: Symbol}) }
      def to_hash
      end

      class Filter < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, OpenAI::Models::ComparisonFilter], [NilClass, T.anything]]) }
          private def variants
          end
        end
      end

      class Type < OpenAI::Enum
        abstract!

        AND = :and
        OR = :or

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
