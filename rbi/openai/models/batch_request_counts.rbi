# typed: strong

module OpenAI
  module Models
    class BatchRequestCounts < OpenAI::Internal::Type::BaseModel
      # Number of requests that have been completed successfully.
      sig { returns(Integer) }
      attr_accessor :completed

      # Number of requests that have failed.
      sig { returns(Integer) }
      attr_accessor :failed

      # Total number of requests in the batch.
      sig { returns(Integer) }
      attr_accessor :total

      # The request counts for different statuses within the batch.
      sig { params(completed: Integer, failed: Integer, total: Integer).returns(T.attached_class) }
      def self.new(
        # Number of requests that have been completed successfully.
        completed:,
        # Number of requests that have failed.
        failed:,
        # Total number of requests in the batch.
        total:
      ); end
      sig { override.returns({completed: Integer, failed: Integer, total: Integer}) }
      def to_hash; end
    end
  end
end
