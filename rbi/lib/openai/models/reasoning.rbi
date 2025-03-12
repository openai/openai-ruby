# typed: strong

module OpenAI
  module Models
    class Reasoning < OpenAI::BaseModel
      sig { returns(T.nilable(Symbol)) }
      def effort
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def effort=(_)
      end

      sig { returns(T.nilable(Symbol)) }
      def generate_summary
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def generate_summary=(_)
      end

      sig { params(effort: T.nilable(Symbol), generate_summary: T.nilable(Symbol)).returns(T.attached_class) }
      def self.new(effort:, generate_summary: nil)
      end

      sig { override.returns({effort: T.nilable(Symbol), generate_summary: T.nilable(Symbol)}) }
      def to_hash
      end

      class GenerateSummary < OpenAI::Enum
        abstract!

        CONCISE = T.let(:concise, T.nilable(Symbol))
        DETAILED = T.let(:detailed, T.nilable(Symbol))

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
