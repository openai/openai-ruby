# frozen_string_literal: true

module OpenAI
  module Models
    class VectorStore < OpenAI::BaseModel
      # @!attribute id
      #   The identifier, which can be referenced in API endpoints.
      #
      #   @return [String]
      required :id, String

      # @!attribute created_at
      #   The Unix timestamp (in seconds) for when the vector store was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute file_counts
      #
      #   @return [OpenAI::Models::VectorStore::FileCounts]
      required :file_counts, -> { OpenAI::Models::VectorStore::FileCounts }

      # @!attribute last_active_at
      #   The Unix timestamp (in seconds) for when the vector store was last active.
      #
      #   @return [Integer, nil]
      required :last_active_at, Integer, nil?: true

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      required :metadata, OpenAI::HashOf[String], nil?: true

      # @!attribute name
      #   The name of the vector store.
      #
      #   @return [String]
      required :name, String

      # @!attribute object
      #   The object type, which is always `vector_store`.
      #
      #   @return [Symbol, :vector_store]
      required :object, const: :vector_store

      # @!attribute status
      #   The status of the vector store, which can be either `expired`, `in_progress`, or
      #     `completed`. A status of `completed` indicates that the vector store is ready
      #     for use.
      #
      #   @return [Symbol, OpenAI::Models::VectorStore::Status]
      required :status, enum: -> { OpenAI::Models::VectorStore::Status }

      # @!attribute usage_bytes
      #   The total number of bytes used by the files in the vector store.
      #
      #   @return [Integer]
      required :usage_bytes, Integer

      # @!attribute [r] expires_after
      #   The expiration policy for a vector store.
      #
      #   @return [OpenAI::Models::VectorStore::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::Models::VectorStore::ExpiresAfter }

      # @!parse
      #   # @return [OpenAI::Models::VectorStore::ExpiresAfter]
      #   attr_writer :expires_after

      # @!attribute expires_at
      #   The Unix timestamp (in seconds) for when the vector store will expire.
      #
      #   @return [Integer, nil]
      optional :expires_at, Integer, nil?: true

      # @!parse
      #   # A vector store is a collection of processed files can be used by the
      #   #   `file_search` tool.
      #   #
      #   # @param id [String]
      #   # @param created_at [Integer]
      #   # @param file_counts [OpenAI::Models::VectorStore::FileCounts]
      #   # @param last_active_at [Integer, nil]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param name [String]
      #   # @param status [Symbol, OpenAI::Models::VectorStore::Status]
      #   # @param usage_bytes [Integer]
      #   # @param expires_after [OpenAI::Models::VectorStore::ExpiresAfter]
      #   # @param expires_at [Integer, nil]
      #   # @param object [Symbol, :vector_store]
      #   #
      #   def initialize(
      #     id:,
      #     created_at:,
      #     file_counts:,
      #     last_active_at:,
      #     metadata:,
      #     name:,
      #     status:,
      #     usage_bytes:,
      #     expires_after: nil,
      #     expires_at: nil,
      #     object: :vector_store,
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      class FileCounts < OpenAI::BaseModel
        # @!attribute cancelled
        #   The number of files that were cancelled.
        #
        #   @return [Integer]
        required :cancelled, Integer

        # @!attribute completed
        #   The number of files that have been successfully processed.
        #
        #   @return [Integer]
        required :completed, Integer

        # @!attribute failed
        #   The number of files that have failed to process.
        #
        #   @return [Integer]
        required :failed, Integer

        # @!attribute in_progress
        #   The number of files that are currently being processed.
        #
        #   @return [Integer]
        required :in_progress, Integer

        # @!attribute total
        #   The total number of files.
        #
        #   @return [Integer]
        required :total, Integer

        # @!parse
        #   # @param cancelled [Integer]
        #   # @param completed [Integer]
        #   # @param failed [Integer]
        #   # @param in_progress [Integer]
        #   # @param total [Integer]
        #   #
        #   def initialize(cancelled:, completed:, failed:, in_progress:, total:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      #   `completed`. A status of `completed` indicates that the vector store is ready
      #   for use.
      module Status
        extend OpenAI::Enum

        EXPIRED = :expired
        IN_PROGRESS = :in_progress
        COMPLETED = :completed

        finalize!
      end

      class ExpiresAfter < OpenAI::BaseModel
        # @!attribute anchor
        #   Anchor timestamp after which the expiration policy applies. Supported anchors:
        #     `last_active_at`.
        #
        #   @return [Symbol, :last_active_at]
        required :anchor, const: :last_active_at

        # @!attribute days
        #   The number of days after the anchor time that the vector store will expire.
        #
        #   @return [Integer]
        required :days, Integer

        # @!parse
        #   # The expiration policy for a vector store.
        #   #
        #   # @param days [Integer]
        #   # @param anchor [Symbol, :last_active_at]
        #   #
        #   def initialize(days:, anchor: :last_active_at, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
