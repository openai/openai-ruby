# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Batches#create
    class Batch < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #
      #   @return [String]
      required :id, String

      # @!attribute completion_window
      #   The time frame within which the batch should be processed.
      #
      #   @return [String]
      required :completion_window, String

      # @!attribute created_at
      #   The Unix timestamp (in seconds) for when the batch was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute endpoint
      #   The OpenAI API endpoint used by the batch.
      #
      #   @return [String]
      required :endpoint, String

      # @!attribute input_file_id
      #   The ID of the input file for the batch.
      #
      #   @return [String]
      required :input_file_id, String

      # @!attribute object
      #   The object type, which is always `batch`.
      #
      #   @return [Symbol, :batch]
      required :object, const: :batch

      # @!attribute status
      #   The current status of the batch.
      #
      #   @return [Symbol, OpenAI::Models::Batch::Status]
      required :status, enum: -> { OpenAI::Batch::Status }

      # @!attribute cancelled_at
      #   The Unix timestamp (in seconds) for when the batch was cancelled.
      #
      #   @return [Integer, nil]
      optional :cancelled_at, Integer

      # @!attribute cancelling_at
      #   The Unix timestamp (in seconds) for when the batch started cancelling.
      #
      #   @return [Integer, nil]
      optional :cancelling_at, Integer

      # @!attribute completed_at
      #   The Unix timestamp (in seconds) for when the batch was completed.
      #
      #   @return [Integer, nil]
      optional :completed_at, Integer

      # @!attribute error_file_id
      #   The ID of the file containing the outputs of requests with errors.
      #
      #   @return [String, nil]
      optional :error_file_id, String

      # @!attribute errors
      #
      #   @return [OpenAI::Models::Batch::Errors, nil]
      optional :errors, -> { OpenAI::Batch::Errors }

      # @!attribute expired_at
      #   The Unix timestamp (in seconds) for when the batch expired.
      #
      #   @return [Integer, nil]
      optional :expired_at, Integer

      # @!attribute expires_at
      #   The Unix timestamp (in seconds) for when the batch will expire.
      #
      #   @return [Integer, nil]
      optional :expires_at, Integer

      # @!attribute failed_at
      #   The Unix timestamp (in seconds) for when the batch failed.
      #
      #   @return [Integer, nil]
      optional :failed_at, Integer

      # @!attribute finalizing_at
      #   The Unix timestamp (in seconds) for when the batch started finalizing.
      #
      #   @return [Integer, nil]
      optional :finalizing_at, Integer

      # @!attribute in_progress_at
      #   The Unix timestamp (in seconds) for when the batch started processing.
      #
      #   @return [Integer, nil]
      optional :in_progress_at, Integer

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!attribute output_file_id
      #   The ID of the file containing the outputs of successfully executed requests.
      #
      #   @return [String, nil]
      optional :output_file_id, String

      # @!attribute request_counts
      #   The request counts for different statuses within the batch.
      #
      #   @return [OpenAI::Models::BatchRequestCounts, nil]
      optional :request_counts, -> { OpenAI::BatchRequestCounts }

      # @!method initialize(id:, completion_window:, created_at:, endpoint:, input_file_id:, status:, cancelled_at: nil, cancelling_at: nil, completed_at: nil, error_file_id: nil, errors: nil, expired_at: nil, expires_at: nil, failed_at: nil, finalizing_at: nil, in_progress_at: nil, metadata: nil, output_file_id: nil, request_counts: nil, object: :batch)
      #   Some parameter documentations has been truncated, see {OpenAI::Models::Batch}
      #   for more details.
      #
      #   @param id [String]
      #
      #   @param completion_window [String] The time frame within which the batch should be processed.
      #
      #   @param created_at [Integer] The Unix timestamp (in seconds) for when the batch was created.
      #
      #   @param endpoint [String] The OpenAI API endpoint used by the batch.
      #
      #   @param input_file_id [String] The ID of the input file for the batch.
      #
      #   @param status [Symbol, OpenAI::Models::Batch::Status] The current status of the batch.
      #
      #   @param cancelled_at [Integer] The Unix timestamp (in seconds) for when the batch was cancelled.
      #
      #   @param cancelling_at [Integer] The Unix timestamp (in seconds) for when the batch started cancelling.
      #
      #   @param completed_at [Integer] The Unix timestamp (in seconds) for when the batch was completed.
      #
      #   @param error_file_id [String] The ID of the file containing the outputs of requests with errors.
      #
      #   @param errors [OpenAI::Models::Batch::Errors]
      #
      #   @param expired_at [Integer] The Unix timestamp (in seconds) for when the batch expired.
      #
      #   @param expires_at [Integer] The Unix timestamp (in seconds) for when the batch will expire.
      #
      #   @param failed_at [Integer] The Unix timestamp (in seconds) for when the batch failed.
      #
      #   @param finalizing_at [Integer] The Unix timestamp (in seconds) for when the batch started finalizing.
      #
      #   @param in_progress_at [Integer] The Unix timestamp (in seconds) for when the batch started processing.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param output_file_id [String] The ID of the file containing the outputs of successfully executed requests.
      #
      #   @param request_counts [OpenAI::Models::BatchRequestCounts] The request counts for different statuses within the batch.
      #
      #   @param object [Symbol, :batch] The object type, which is always `batch`.

      # The current status of the batch.
      #
      # @see OpenAI::Models::Batch#status
      module Status
        extend OpenAI::Internal::Type::Enum

        VALIDATING = :validating
        FAILED = :failed
        IN_PROGRESS = :in_progress
        FINALIZING = :finalizing
        COMPLETED = :completed
        EXPIRED = :expired
        CANCELLING = :cancelling
        CANCELLED = :cancelled

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @see OpenAI::Models::Batch#errors
      class Errors < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #
        #   @return [Array<OpenAI::Models::BatchError>, nil]
        optional :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::BatchError] }

        # @!attribute object
        #   The object type, which is always `list`.
        #
        #   @return [String, nil]
        optional :object, String

        # @!method initialize(data: nil, object: nil)
        #   @param data [Array<OpenAI::Models::BatchError>]
        #
        #   @param object [String] The object type, which is always `list`.
      end
    end
  end
end
