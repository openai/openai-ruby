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
        #   @return [OpenAI::VectorStores::VectorStoreFileBatch::FileCounts]
        required :file_counts, -> { OpenAI::VectorStores::VectorStoreFileBatch::FileCounts }

        # @!attribute object
        #   The object type, which is always `vector_store.file_batch`.
        #
        #   @return [Symbol, :"vector_store.files_batch"]
        required :object, const: :"vector_store.files_batch"

        # @!attribute status
        #   The status of the vector store files batch, which can be either `in_progress`,
        #   `completed`, `cancelled` or `failed`.
        #
        #   @return [Symbol, OpenAI::VectorStores::VectorStoreFileBatch::Status]
        required :status, enum: -> { OpenAI::VectorStores::VectorStoreFileBatch::Status }

        # @!attribute vector_store_id
        #   The ID of the
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        #   that the [File](https://platform.openai.com/docs/api-reference/files) is
        #   attached to.
        #
        #   @return [String]
        required :vector_store_id, String

        # @!method initialize(id:, created_at:, file_counts:, status:, vector_store_id:, object: :"vector_store.files_batch")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::VectorStores::VectorStoreFileBatch} for more details.
        #
        #   A batch of files attached to a vector store.
        #
        #   @param id [String] The identifier, which can be referenced in API endpoints.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) for when the vector store files batch was create
        #
        #   @param file_counts [OpenAI::VectorStores::VectorStoreFileBatch::FileCounts]
        #
        #   @param status [Symbol, OpenAI::VectorStores::VectorStoreFileBatch::Status] The status of the vector store files batch, which can be either `in_progress`, `
        #
        #   @param vector_store_id [String] The ID of the [vector store](https://platform.openai.com/docs/api-reference/vect
        #
        #   @param object [Symbol, :"vector_store.files_batch"] The object type, which is always `vector_store.file_batch`.

        # @see OpenAI::VectorStores::VectorStoreFileBatch#file_counts
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

          # @!method initialize(cancelled:, completed:, failed:, in_progress:, total:)
          #   @param cancelled [Integer] The number of files that where cancelled.
          #
          #   @param completed [Integer] The number of files that have been processed.
          #
          #   @param failed [Integer] The number of files that have failed to process.
          #
          #   @param in_progress [Integer] The number of files that are currently being processed.
          #
          #   @param total [Integer] The total number of files.
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        #
        # @see OpenAI::VectorStores::VectorStoreFileBatch#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          CANCELLED = :cancelled
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    VectorStoreFileBatch = VectorStores::VectorStoreFileBatch
  end
end
