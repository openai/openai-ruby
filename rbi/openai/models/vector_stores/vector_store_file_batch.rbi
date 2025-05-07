# typed: strong

module OpenAI
  module Models
    VectorStoreFileBatch = VectorStores::VectorStoreFileBatch

    module VectorStores
      class VectorStoreFileBatch < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the vector store files batch was
        # created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::VectorStores::VectorStoreFileBatch::FileCounts) }
        attr_reader :file_counts

        sig do
          params(
            file_counts:
              OpenAI::VectorStores::VectorStoreFileBatch::FileCounts::OrHash
          ).void
        end
        attr_writer :file_counts

        # The object type, which is always `vector_store.file_batch`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        sig do
          returns(
            OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
          )
        end
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
            file_counts:
              OpenAI::VectorStores::VectorStoreFileBatch::FileCounts::OrHash,
            status:
              OpenAI::VectorStores::VectorStoreFileBatch::Status::OrSymbol,
            vector_store_id: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The identifier, which can be referenced in API endpoints.
          id:,
          # The Unix timestamp (in seconds) for when the vector store files batch was
          # created.
          created_at:,
          file_counts:,
          # The status of the vector store files batch, which can be either `in_progress`,
          # `completed`, `cancelled` or `failed`.
          status:,
          # The ID of the
          # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
          # that the [File](https://platform.openai.com/docs/api-reference/files) is
          # attached to.
          vector_store_id:,
          # The object type, which is always `vector_store.file_batch`.
          object: :"vector_store.files_batch"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              file_counts:
                OpenAI::VectorStores::VectorStoreFileBatch::FileCounts,
              object: Symbol,
              status:
                OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol,
              vector_store_id: String
            }
          )
        end
        def to_hash
        end

        class FileCounts < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
            ).returns(T.attached_class)
          end
          def self.new(
            # The number of files that where cancelled.
            cancelled:,
            # The number of files that have been processed.
            completed:,
            # The number of files that have failed to process.
            failed:,
            # The number of files that are currently being processed.
            in_progress:,
            # The total number of files.
            total:
          )
          end

          sig do
            override.returns(
              {
                cancelled: Integer,
                completed: Integer,
                failed: Integer,
                in_progress: Integer,
                total: Integer
              }
            )
          end
          def to_hash
          end
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        # `completed`, `cancelled` or `failed`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::VectorStores::VectorStoreFileBatch::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
            )
          CANCELLED =
            T.let(
              :cancelled,
              OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::VectorStores::VectorStoreFileBatch::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
