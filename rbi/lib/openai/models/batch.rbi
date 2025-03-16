# typed: strong

module OpenAI
  module Models
    class Batch < OpenAI::BaseModel
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The time frame within which the batch should be processed.
      sig { returns(String) }
      def completion_window
      end

      sig { params(_: String).returns(String) }
      def completion_window=(_)
      end

      # The Unix timestamp (in seconds) for when the batch was created.
      sig { returns(Integer) }
      def created_at
      end

      sig { params(_: Integer).returns(Integer) }
      def created_at=(_)
      end

      # The OpenAI API endpoint used by the batch.
      sig { returns(String) }
      def endpoint
      end

      sig { params(_: String).returns(String) }
      def endpoint=(_)
      end

      # The ID of the input file for the batch.
      sig { returns(String) }
      def input_file_id
      end

      sig { params(_: String).returns(String) }
      def input_file_id=(_)
      end

      # The object type, which is always `batch`.
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The current status of the batch.
      sig { returns(Symbol) }
      def status
      end

      sig { params(_: Symbol).returns(Symbol) }
      def status=(_)
      end

      # The Unix timestamp (in seconds) for when the batch was cancelled.
      sig { returns(T.nilable(Integer)) }
      def cancelled_at
      end

      sig { params(_: Integer).returns(Integer) }
      def cancelled_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch started cancelling.
      sig { returns(T.nilable(Integer)) }
      def cancelling_at
      end

      sig { params(_: Integer).returns(Integer) }
      def cancelling_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch was completed.
      sig { returns(T.nilable(Integer)) }
      def completed_at
      end

      sig { params(_: Integer).returns(Integer) }
      def completed_at=(_)
      end

      # The ID of the file containing the outputs of requests with errors.
      sig { returns(T.nilable(String)) }
      def error_file_id
      end

      sig { params(_: String).returns(String) }
      def error_file_id=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Batch::Errors)) }
      def errors
      end

      sig { params(_: OpenAI::Models::Batch::Errors).returns(OpenAI::Models::Batch::Errors) }
      def errors=(_)
      end

      # The Unix timestamp (in seconds) for when the batch expired.
      sig { returns(T.nilable(Integer)) }
      def expired_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expired_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch will expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expires_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch failed.
      sig { returns(T.nilable(Integer)) }
      def failed_at
      end

      sig { params(_: Integer).returns(Integer) }
      def failed_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch started finalizing.
      sig { returns(T.nilable(Integer)) }
      def finalizing_at
      end

      sig { params(_: Integer).returns(Integer) }
      def finalizing_at=(_)
      end

      # The Unix timestamp (in seconds) for when the batch started processing.
      sig { returns(T.nilable(Integer)) }
      def in_progress_at
      end

      sig { params(_: Integer).returns(Integer) }
      def in_progress_at=(_)
      end

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

      # The ID of the file containing the outputs of successfully executed requests.
      sig { returns(T.nilable(String)) }
      def output_file_id
      end

      sig { params(_: String).returns(String) }
      def output_file_id=(_)
      end

      # The request counts for different statuses within the batch.
      sig { returns(T.nilable(OpenAI::Models::BatchRequestCounts)) }
      def request_counts
      end

      sig { params(_: OpenAI::Models::BatchRequestCounts).returns(OpenAI::Models::BatchRequestCounts) }
      def request_counts=(_)
      end

      sig do
        params(
          id: String,
          completion_window: String,
          created_at: Integer,
          endpoint: String,
          input_file_id: String,
          status: Symbol,
          cancelled_at: Integer,
          cancelling_at: Integer,
          completed_at: Integer,
          error_file_id: String,
          errors: OpenAI::Models::Batch::Errors,
          expired_at: Integer,
          expires_at: Integer,
          failed_at: Integer,
          finalizing_at: Integer,
          in_progress_at: Integer,
          metadata: T.nilable(OpenAI::Models::Metadata),
          output_file_id: String,
          request_counts: OpenAI::Models::BatchRequestCounts,
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        id:,
        completion_window:,
        created_at:,
        endpoint:,
        input_file_id:,
        status:,
        cancelled_at: nil,
        cancelling_at: nil,
        completed_at: nil,
        error_file_id: nil,
        errors: nil,
        expired_at: nil,
        expires_at: nil,
        failed_at: nil,
        finalizing_at: nil,
        in_progress_at: nil,
        metadata: nil,
        output_file_id: nil,
        request_counts: nil,
        object: :batch
      )
      end

      sig do
        override
          .returns(
            {
              id: String,
              completion_window: String,
              created_at: Integer,
              endpoint: String,
              input_file_id: String,
              object: Symbol,
              status: Symbol,
              cancelled_at: Integer,
              cancelling_at: Integer,
              completed_at: Integer,
              error_file_id: String,
              errors: OpenAI::Models::Batch::Errors,
              expired_at: Integer,
              expires_at: Integer,
              failed_at: Integer,
              finalizing_at: Integer,
              in_progress_at: Integer,
              metadata: T.nilable(OpenAI::Models::Metadata),
              output_file_id: String,
              request_counts: OpenAI::Models::BatchRequestCounts
            }
          )
      end
      def to_hash
      end

      # The current status of the batch.
      class Status < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        VALIDATING = :validating
        FAILED = :failed
        IN_PROGRESS = :in_progress
        FINALIZING = :finalizing
        COMPLETED = :completed
        EXPIRED = :expired
        CANCELLING = :cancelling
        CANCELLED = :cancelled
      end

      class Errors < OpenAI::BaseModel
        sig { returns(T.nilable(T::Array[OpenAI::Models::BatchError])) }
        def data
        end

        sig { params(_: T::Array[OpenAI::Models::BatchError]).returns(T::Array[OpenAI::Models::BatchError]) }
        def data=(_)
        end

        # The object type, which is always `list`.
        sig { returns(T.nilable(String)) }
        def object
        end

        sig { params(_: String).returns(String) }
        def object=(_)
        end

        sig { params(data: T::Array[OpenAI::Models::BatchError], object: String).returns(T.attached_class) }
        def self.new(data: nil, object: nil)
        end

        sig { override.returns({data: T::Array[OpenAI::Models::BatchError], object: String}) }
        def to_hash
        end
      end
    end
  end
end
