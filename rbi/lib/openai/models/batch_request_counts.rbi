# typed: strong

module OpenAI
  module Models
    class BatchRequestCounts < OpenAI::BaseModel
      sig { returns(Integer) }
      def completed
      end

      sig { params(_: Integer).returns(Integer) }
      def completed=(_)
      end

      sig { returns(Integer) }
      def failed
      end

      sig { params(_: Integer).returns(Integer) }
      def failed=(_)
      end

      sig { returns(Integer) }
      def total
      end

      sig { params(_: Integer).returns(Integer) }
      def total=(_)
      end

      sig { params(completed: Integer, failed: Integer, total: Integer).returns(T.attached_class) }
      def self.new(completed:, failed:, total:)
      end

      sig { override.returns({completed: Integer, failed: Integer, total: Integer}) }
      def to_hash
      end
    end
  end
end
