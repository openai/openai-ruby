# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Batches#create
    class Batch < OpenAI::BaseModel
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
      required :status, enum: -> { OpenAI::Models::Batch::Status }

      # @!attribute [r] cancelled_at
      #   The Unix timestamp (in seconds) for when the batch was cancelled.
      #
      #   @return [Integer, nil]
      optional :cancelled_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :cancelled_at

      # @!attribute [r] cancelling_at
      #   The Unix timestamp (in seconds) for when the batch started cancelling.
      #
      #   @return [Integer, nil]
      optional :cancelling_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :cancelling_at

      # @!attribute [r] completed_at
      #   The Unix timestamp (in seconds) for when the batch was completed.
      #
      #   @return [Integer, nil]
      optional :completed_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :completed_at

      # @!attribute [r] error_file_id
      #   The ID of the file containing the outputs of requests with errors.
      #
      #   @return [String, nil]
      optional :error_file_id, String

      # @!parse
      #   # @return [String]
      #   attr_writer :error_file_id

      # @!attribute [r] errors
      #
      #   @return [OpenAI::Models::Batch::Errors, nil]
      optional :errors, -> { OpenAI::Models::Batch::Errors }

      # @!parse
      #   # @return [OpenAI::Models::Batch::Errors]
      #   attr_writer :errors

      # @!attribute [r] expired_at
      #   The Unix timestamp (in seconds) for when the batch expired.
      #
      #   @return [Integer, nil]
      optional :expired_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :expired_at

      # @!attribute [r] expires_at
      #   The Unix timestamp (in seconds) for when the batch will expire.
      #
      #   @return [Integer, nil]
      optional :expires_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :expires_at

      # @!attribute [r] failed_at
      #   The Unix timestamp (in seconds) for when the batch failed.
      #
      #   @return [Integer, nil]
      optional :failed_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :failed_at

      # @!attribute [r] finalizing_at
      #   The Unix timestamp (in seconds) for when the batch started finalizing.
      #
      #   @return [Integer, nil]
      optional :finalizing_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :finalizing_at

      # @!attribute [r] in_progress_at
      #   The Unix timestamp (in seconds) for when the batch started processing.
      #
      #   @return [Integer, nil]
      optional :in_progress_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :in_progress_at

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::HashOf[String], nil?: true

      # @!attribute [r] output_file_id
      #   The ID of the file containing the outputs of successfully executed requests.
      #
      #   @return [String, nil]
      optional :output_file_id, String

      # @!parse
      #   # @return [String]
      #   attr_writer :output_file_id

      # @!attribute [r] request_counts
      #   The request counts for different statuses within the batch.
      #
      #   @return [OpenAI::Models::BatchRequestCounts, nil]
      optional :request_counts, -> { OpenAI::Models::BatchRequestCounts }

      # @!parse
      #   # @return [OpenAI::Models::BatchRequestCounts]
      #   attr_writer :request_counts

      # @!parse
      #   # @param id [String]
      #   # @param completion_window [String]
      #   # @param created_at [Integer]
      #   # @param endpoint [String]
      #   # @param input_file_id [String]
      #   # @param status [Symbol, OpenAI::Models::Batch::Status]
      #   # @param cancelled_at [Integer]
      #   # @param cancelling_at [Integer]
      #   # @param completed_at [Integer]
      #   # @param error_file_id [String]
      #   # @param errors [OpenAI::Models::Batch::Errors]
      #   # @param expired_at [Integer]
      #   # @param expires_at [Integer]
      #   # @param failed_at [Integer]
      #   # @param finalizing_at [Integer]
      #   # @param in_progress_at [Integer]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param output_file_id [String]
      #   # @param request_counts [OpenAI::Models::BatchRequestCounts]
      #   # @param object [Symbol, :batch]
      #   #
      #   def initialize(
      #     id:,
      #     completion_window:,
      #     created_at:,
      #     endpoint:,
      #     input_file_id:,
      #     status:,
      #     cancelled_at: nil,
      #     cancelling_at: nil,
      #     completed_at: nil,
      #     error_file_id: nil,
      #     errors: nil,
      #     expired_at: nil,
      #     expires_at: nil,
      #     failed_at: nil,
      #     finalizing_at: nil,
      #     in_progress_at: nil,
      #     metadata: nil,
      #     output_file_id: nil,
      #     request_counts: nil,
      #     object: :batch,
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # The current status of the batch.
      #
      # @see OpenAI::Models::Batch#status
      module Status
        extend OpenAI::Enum

        VALIDATING = :validating
        FAILED = :failed
        IN_PROGRESS = :in_progress
        FINALIZING = :finalizing
        COMPLETED = :completed
        EXPIRED = :expired
        CANCELLING = :cancelling
        CANCELLED = :cancelled

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # @see OpenAI::Models::Batch#errors
      class Errors < OpenAI::BaseModel
        # @!attribute [r] data
        #
        #   @return [Array<OpenAI::Models::BatchError>, nil]
        optional :data, -> { OpenAI::ArrayOf[OpenAI::Models::BatchError] }

        # @!parse
        #   # @return [Array<OpenAI::Models::BatchError>]
        #   attr_writer :data

        # @!attribute [r] object
        #   The object type, which is always `list`.
        #
        #   @return [String, nil]
        optional :object, String

        # @!parse
        #   # @return [String]
        #   attr_writer :object

        # @!parse
        #   # @param data [Array<OpenAI::Models::BatchError>]
        #   # @param object [String]
        #   #
        #   def initialize(data: nil, object: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
