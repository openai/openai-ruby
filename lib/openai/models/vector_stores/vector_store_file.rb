# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#create
      class VectorStoreFile < OpenAI::Internal::Type::BaseModel
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
        #   are no errors.
        #
        #   @return [OpenAI::Models::VectorStores::VectorStoreFile::LastError, nil]
        required :last_error, -> { OpenAI::VectorStores::VectorStoreFile::LastError }, nil?: true

        # @!attribute object
        #   The object type, which is always `vector_store.file`.
        #
        #   @return [Symbol, :"vector_store.file"]
        required :object, const: :"vector_store.file"

        # @!attribute status
        #   The status of the vector store file, which can be either `in_progress`,
        #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        #   vector store file is ready for use.
        #
        #   @return [Symbol, OpenAI::Models::VectorStores::VectorStoreFile::Status]
        required :status, enum: -> { OpenAI::VectorStores::VectorStoreFile::Status }

        # @!attribute usage_bytes
        #   The total vector store usage in bytes. Note that this may be different from the
        #   original file size.
        #
        #   @return [Integer]
        required :usage_bytes, Integer

        # @!attribute vector_store_id
        #   The ID of the
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        #   that the [File](https://platform.openai.com/docs/api-reference/files) is
        #   attached to.
        #
        #   @return [String]
        required :vector_store_id, String

        # @!attribute attributes
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        #
        #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
        optional :attributes,
                 -> {
                   OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::VectorStoreFile::Attribute]
                 },
                 nil?: true

        # @!attribute chunking_strategy
        #   The strategy used to chunk the file.
        #
        #   @return [OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject, nil]
        optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategy }

        # @!method initialize(id:, created_at:, last_error:, status:, usage_bytes:, vector_store_id:, attributes: nil, chunking_strategy: nil, object: :"vector_store.file")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::VectorStores::VectorStoreFile} for more details.
        #
        #   A list of files attached to a vector store.
        #
        #   @param id [String] The identifier, which can be referenced in API endpoints.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) for when the vector store file was created.
        #
        #   @param last_error [OpenAI::Models::VectorStores::VectorStoreFile::LastError, nil] The last error associated with this vector store file. Will be `null` if there a
        #
        #   @param status [Symbol, OpenAI::Models::VectorStores::VectorStoreFile::Status] The status of the vector store file, which can be either `in_progress`, `complet
        #
        #   @param usage_bytes [Integer] The total vector store usage in bytes. Note that this may be different from the
        #
        #   @param vector_store_id [String] The ID of the [vector store](https://platform.openai.com/docs/api-reference/vect
        #
        #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param chunking_strategy [OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject] The strategy used to chunk the file.
        #
        #   @param object [Symbol, :"vector_store.file"] The object type, which is always `vector_store.file`.

        # @see OpenAI::Models::VectorStores::VectorStoreFile#last_error
        class LastError < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   One of `server_error`, `unsupported_file`, or `invalid_file`.
          #
          #   @return [Symbol, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code]
          required :code, enum: -> { OpenAI::VectorStores::VectorStoreFile::LastError::Code }

          # @!attribute message
          #   A human-readable description of the error.
          #
          #   @return [String]
          required :message, String

          # @!method initialize(code:, message:)
          #   The last error associated with this vector store file. Will be `null` if there
          #   are no errors.
          #
          #   @param code [Symbol, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code] One of `server_error`, `unsupported_file`, or `invalid_file`.
          #
          #   @param message [String] A human-readable description of the error.

          # One of `server_error`, `unsupported_file`, or `invalid_file`.
          #
          # @see OpenAI::Models::VectorStores::VectorStoreFile::LastError#code
          module Code
            extend OpenAI::Internal::Type::Enum

            SERVER_ERROR = :server_error
            UNSUPPORTED_FILE = :unsupported_file
            INVALID_FILE = :invalid_file

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # The status of the vector store file, which can be either `in_progress`,
        # `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        # vector store file is ready for use.
        #
        # @see OpenAI::Models::VectorStores::VectorStoreFile#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          CANCELLED = :cancelled
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module Attribute
          extend OpenAI::Internal::Type::Union

          variant String

          variant Float

          variant OpenAI::Internal::Type::Boolean

          # @!method self.variants
          #   @return [Array(String, Float, Boolean)]
        end
      end
    end

    VectorStoreFile = VectorStores::VectorStoreFile
  end
end
