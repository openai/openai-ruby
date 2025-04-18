# typed: strong

module OpenAI
  module Models
    module VectorStores
      class VectorStoreFileBatch < OpenAI::Internal::Type::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the vector store files batch was
        # created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts) }
        attr_reader :file_counts

        sig do
          params(
            file_counts: T.any(OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :file_counts

        # The object type, which is always `vector_store.file_batch`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        sig { returns(OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol) }
        attr_accessor :status

        # The ID of the
        # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        # that the [File](https://platform.openai.com/docs/api-reference/files) is
        # attached to.
        sig { returns(String) }
        attr_accessor :vector_store_id

        # A batch of files attached to a vector store.
        sig do
          params(
            id: String,
            created_at: Integer,
            file_counts: T.any(OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts, OpenAI::Internal::AnyHash),
            status: OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::OrSymbol,
            vector_store_id: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          file_counts:,
          status:,
          vector_store_id:,
          object: :"vector_store.files_batch"
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                file_counts: OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts,
                object: Symbol,
                status: OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol,
                vector_store_id: String
              }
            )
        end
        def to_hash; end

        class FileCounts < OpenAI::Internal::Type::BaseModel
          # The number of files that where cancelled.
          sig { returns(Integer) }
          attr_accessor :cancelled

          # The number of files that have been processed.
          sig { returns(Integer) }
          attr_accessor :completed

          # The number of files that have failed to process.
          sig { returns(Integer) }
          attr_accessor :failed

          # The number of files that are currently being processed.
          sig { returns(Integer) }
          attr_accessor :in_progress

          # The total number of files.
          sig { returns(Integer) }
          attr_accessor :total

          sig do
            params(
              cancelled: Integer,
              completed: Integer,
              failed: Integer,
              in_progress: Integer,
              total: Integer
            )
              .returns(T.attached_class)
          end
          def self.new(cancelled:, completed:, failed:, in_progress:, total:); end

          sig do
            override
              .returns({
                         cancelled: Integer,
                         completed: Integer,
                         failed: Integer,
                         in_progress: Integer,
                         total: Integer
                       })
          end
          def to_hash; end
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol]) }
          def self.values; end
        end
      end
    end

    VectorStoreFileBatch = VectorStores::VectorStoreFileBatch
  end
end
