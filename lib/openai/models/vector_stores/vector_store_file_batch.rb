# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::FileBatches#create
      class VectorStoreFileBatch < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The identifier, which can be referenced in API endpoints.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the vector store files batch was
        #   created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute file_counts
        #
        #   @return [OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts]
        required :file_counts, -> { OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts }

        # @!attribute object
        #   The object type, which is always `vector_store.file_batch`.
        #
        #   @return [Symbol, :"vector_store.files_batch"]
        required :object, const: :"vector_store.files_batch"

        # @!attribute status
        #   The status of the vector store files batch, which can be either `in_progress`,
        #   `completed`, `cancelled` or `failed`.
        #
        #   @return [Symbol, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status]
        required :status, enum: -> { OpenAI::Models::VectorStores::VectorStoreFileBatch::Status }

        # @!attribute vector_store_id
        #   The ID of the
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        #   that the [File](https://platform.openai.com/docs/api-reference/files) is
        #   attached to.
        #
        #   @return [String]
        required :vector_store_id, String

        # @!parse
        #   # A batch of files attached to a vector store.
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param file_counts [OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts]
        #   # @param status [Symbol, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status]
        #   # @param vector_store_id [String]
        #   # @param object [Symbol, :"vector_store.files_batch"]
        #   #
        #   def initialize(id:, created_at:, file_counts:, status:, vector_store_id:, object: :"vector_store.files_batch", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # @see OpenAI::Models::VectorStores::VectorStoreFileBatch#file_counts
        class FileCounts < OpenAI::Internal::Type::BaseModel
          # @!attribute cancelled
          #   The number of files that where cancelled.
          #
          #   @return [Integer]
          required :cancelled, Integer

          # @!attribute completed
          #   The number of files that have been processed.
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

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        #
        # @see OpenAI::Models::VectorStores::VectorStoreFileBatch#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          CANCELLED = :cancelled
          FAILED = :failed

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end

    VectorStoreFileBatch = VectorStores::VectorStoreFileBatch
  end
end
