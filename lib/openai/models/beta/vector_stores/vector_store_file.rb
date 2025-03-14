# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module VectorStores
        class VectorStoreFile < OpenAI::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) for when the vector store file was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute last_error
          #   The last error associated with this vector store file. Will be `null` if there
          #     are no errors.
          #
          #   @return [OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError, nil]
          required :last_error, -> { OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError }, nil?: true

          # @!attribute object
          #   The object type, which is always `vector_store.file`.
          #
          #   @return [Symbol, :"vector_store.file"]
          required :object, const: :"vector_store.file"

          # @!attribute status
          #   The status of the vector store file, which can be either `in_progress`,
          #     `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
          #     vector store file is ready for use.
          #
          #   @return [Symbol, OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status]
          required :status, enum: -> { OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status }

          # @!attribute usage_bytes
          #   The total vector store usage in bytes. Note that this may be different from the
          #     original file size.
          #
          #   @return [Integer]
          required :usage_bytes, Integer

          # @!attribute vector_store_id
          #   The ID of the
          #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
          #     that the [File](https://platform.openai.com/docs/api-reference/files) is
          #     attached to.
          #
          #   @return [String]
          required :vector_store_id, String

          # @!attribute [r] chunking_strategy
          #   The strategy used to chunk the file.
          #
          #   @return [OpenAI::Models::Beta::StaticFileChunkingStrategyObject, OpenAI::Models::Beta::OtherFileChunkingStrategyObject, nil]
          optional :chunking_strategy, union: -> { OpenAI::Models::Beta::FileChunkingStrategy }

          # @!parse
          #   # @return [OpenAI::Models::Beta::StaticFileChunkingStrategyObject, OpenAI::Models::Beta::OtherFileChunkingStrategyObject]
          #   attr_writer :chunking_strategy

          # @!parse
          #   # A list of files attached to a vector store.
          #   #
          #   # @param id [String]
          #   # @param created_at [Integer]
          #   # @param last_error [OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError, nil]
          #   # @param status [Symbol, OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status]
          #   # @param usage_bytes [Integer]
          #   # @param vector_store_id [String]
          #   # @param chunking_strategy [OpenAI::Models::Beta::StaticFileChunkingStrategyObject, OpenAI::Models::Beta::OtherFileChunkingStrategyObject]
          #   # @param object [Symbol, :"vector_store.file"]
          #   #
          #   def initialize(
          #     id:,
          #     created_at:,
          #     last_error:,
          #     status:,
          #     usage_bytes:,
          #     vector_store_id:,
          #     chunking_strategy: nil,
          #     object: :"vector_store.file",
          #     **
          #   )
          #     super
          #   end

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class LastError < OpenAI::BaseModel
            # @!attribute code
            #   One of `server_error` or `rate_limit_exceeded`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError::Code]
            required :code, enum: -> { OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError::Code }

            # @!attribute message
            #   A human-readable description of the error.
            #
            #   @return [String]
            required :message, String

            # @!parse
            #   # The last error associated with this vector store file. Will be `null` if there
            #   #   are no errors.
            #   #
            #   # @param code [Symbol, OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError::Code]
            #   # @param message [String]
            #   #
            #   def initialize(code:, message:, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            #
            # One of `server_error` or `rate_limit_exceeded`.
            class Code < OpenAI::Enum
              SERVER_ERROR = :server_error
              UNSUPPORTED_FILE = :unsupported_file
              INVALID_FILE = :invalid_file

              finalize!
            end
          end

          # @abstract
          #
          # The status of the vector store file, which can be either `in_progress`,
          #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
          #   vector store file is ready for use.
          class Status < OpenAI::Enum
            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            CANCELLED = :cancelled
            FAILED = :failed

            finalize!
          end
        end
      end

      VectorStoreFile = VectorStores::VectorStoreFile
    end
  end
end
