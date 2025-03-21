# typed: strong

module OpenAI
  module Models
    class BatchRequestCounts < OpenAI::BaseModel
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
      def self.new(completed:, failed:, total:)
      end

      sig { override.returns({completed: Integer, failed: Integer, total: Integer}) }
      def to_hash
      end
    end
  end
end
