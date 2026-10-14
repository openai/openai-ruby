# typed: strong

module OpenAI
  module Models
    class BatchRequestCounts < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::BatchRequestCounts, OpenAI::Internal::AnyHash)
        end

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
      sig do
        params(completed: Integer, failed: Integer, total: Integer).returns(
          T.attached_class
        )
      end
      def self.new(
        # Number of requests that have been completed successfully.
        completed:,
        # Number of requests that have failed.
        failed:,
        # Total number of requests in the batch.
        total:
      )
      end

      sig do
        override.returns(
          { completed: Integer, failed: Integer, total: Integer }
        )
      end
      def to_hash
      end
    end
  end
end
