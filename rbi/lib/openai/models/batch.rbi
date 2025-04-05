# typed: strong

module OpenAI
  module Models
    class Batch < OpenAI::Internal::Type::BaseModel
      sig { returns(String) }
      attr_accessor :id

      # The time frame within which the batch should be processed.
      sig { returns(String) }
      attr_accessor :completion_window

      # The Unix timestamp (in seconds) for when the batch was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The OpenAI API endpoint used by the batch.
      sig { returns(String) }
      attr_accessor :endpoint

      # The ID of the input file for the batch.
      sig { returns(String) }
      attr_accessor :input_file_id

      # The object type, which is always `batch`.
      sig { returns(Symbol) }
      attr_accessor :object

      # The current status of the batch.
      sig { returns(OpenAI::Models::Batch::Status::TaggedSymbol) }
      attr_accessor :status

      # The Unix timestamp (in seconds) for when the batch was cancelled.
      sig { returns(T.nilable(Integer)) }
      attr_reader :cancelled_at

      sig { params(cancelled_at: Integer).void }
      attr_writer :cancelled_at

      # The Unix timestamp (in seconds) for when the batch started cancelling.
      sig { returns(T.nilable(Integer)) }
      attr_reader :cancelling_at

      sig { params(cancelling_at: Integer).void }
      attr_writer :cancelling_at

      # The Unix timestamp (in seconds) for when the batch was completed.
      sig { returns(T.nilable(Integer)) }
      attr_reader :completed_at

      sig { params(completed_at: Integer).void }
      attr_writer :completed_at

      # The ID of the file containing the outputs of requests with errors.
      sig { returns(T.nilable(String)) }
      attr_reader :error_file_id

      sig { params(error_file_id: String).void }
      attr_writer :error_file_id

      sig { returns(T.nilable(OpenAI::Models::Batch::Errors)) }
      attr_reader :errors

      sig { params(errors: T.any(OpenAI::Models::Batch::Errors, OpenAI::Internal::AnyHash)).void }
      attr_writer :errors

      # The Unix timestamp (in seconds) for when the batch expired.
      sig { returns(T.nilable(Integer)) }
      attr_reader :expired_at

      sig { params(expired_at: Integer).void }
      attr_writer :expired_at

      # The Unix timestamp (in seconds) for when the batch will expire.
      sig { returns(T.nilable(Integer)) }
      attr_reader :expires_at

      sig { params(expires_at: Integer).void }
      attr_writer :expires_at

      # The Unix timestamp (in seconds) for when the batch failed.
      sig { returns(T.nilable(Integer)) }
      attr_reader :failed_at

      sig { params(failed_at: Integer).void }
      attr_writer :failed_at

      # The Unix timestamp (in seconds) for when the batch started finalizing.
      sig { returns(T.nilable(Integer)) }
      attr_reader :finalizing_at

      sig { params(finalizing_at: Integer).void }
      attr_writer :finalizing_at

      # The Unix timestamp (in seconds) for when the batch started processing.
      sig { returns(T.nilable(Integer)) }
      attr_reader :in_progress_at

      sig { params(in_progress_at: Integer).void }
      attr_writer :in_progress_at

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The ID of the file containing the outputs of successfully executed requests.
      sig { returns(T.nilable(String)) }
      attr_reader :output_file_id

      sig { params(output_file_id: String).void }
      attr_writer :output_file_id

      # The request counts for different statuses within the batch.
      sig { returns(T.nilable(OpenAI::Models::BatchRequestCounts)) }
      attr_reader :request_counts

      sig { params(request_counts: T.any(OpenAI::Models::BatchRequestCounts, OpenAI::Internal::AnyHash)).void }
      attr_writer :request_counts

      sig do
        params(
          id: String,
          completion_window: String,
          created_at: Integer,
          endpoint: String,
          input_file_id: String,
          status: OpenAI::Models::Batch::Status::OrSymbol,
          cancelled_at: Integer,
          cancelling_at: Integer,
          completed_at: Integer,
          error_file_id: String,
          errors: T.any(OpenAI::Models::Batch::Errors, OpenAI::Internal::AnyHash),
          expired_at: Integer,
          expires_at: Integer,
          failed_at: Integer,
          finalizing_at: Integer,
          in_progress_at: Integer,
          metadata: T.nilable(T::Hash[Symbol, String]),
          output_file_id: String,
          request_counts: T.any(OpenAI::Models::BatchRequestCounts, OpenAI::Internal::AnyHash),
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
      ); end
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
              status: OpenAI::Models::Batch::Status::TaggedSymbol,
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
              metadata: T.nilable(T::Hash[Symbol, String]),
              output_file_id: String,
              request_counts: OpenAI::Models::BatchRequestCounts
            }
          )
      end
      def to_hash; end

      # The current status of the batch.
      module Status
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Batch::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::Batch::Status::TaggedSymbol) }

        VALIDATING = T.let(:validating, OpenAI::Models::Batch::Status::TaggedSymbol)
        FAILED = T.let(:failed, OpenAI::Models::Batch::Status::TaggedSymbol)
        IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Batch::Status::TaggedSymbol)
        FINALIZING = T.let(:finalizing, OpenAI::Models::Batch::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Models::Batch::Status::TaggedSymbol)
        EXPIRED = T.let(:expired, OpenAI::Models::Batch::Status::TaggedSymbol)
        CANCELLING = T.let(:cancelling, OpenAI::Models::Batch::Status::TaggedSymbol)
        CANCELLED = T.let(:cancelled, OpenAI::Models::Batch::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Batch::Status::TaggedSymbol]) }
        def self.values; end
      end

      class Errors < OpenAI::Internal::Type::BaseModel
        sig { returns(T.nilable(T::Array[OpenAI::Models::BatchError])) }
        attr_reader :data

        sig { params(data: T::Array[T.any(OpenAI::Models::BatchError, OpenAI::Internal::AnyHash)]).void }
        attr_writer :data

        # The object type, which is always `list`.
        sig { returns(T.nilable(String)) }
        attr_reader :object

        sig { params(object: String).void }
        attr_writer :object

        sig do
          params(data: T::Array[T.any(OpenAI::Models::BatchError, OpenAI::Internal::AnyHash)], object: String)
            .returns(T.attached_class)
        end
        def self.new(data: nil, object: nil); end

        sig { override.returns({data: T::Array[OpenAI::Models::BatchError], object: String}) }
        def to_hash; end
      end
    end
  end
end
