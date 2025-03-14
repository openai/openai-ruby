# typed: strong

module OpenAI
  module Models
    VectorStoreFileBatch = T.type_alias { VectorStores::VectorStoreFileBatch }

    module VectorStores
      class VectorStoreFileBatch < OpenAI::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the vector store files batch was
        #   created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        sig { returns(OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts) }
        def file_counts
        end

        sig do
          params(_: OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts)
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts)
        end
        def file_counts=(_)
        end

        # The object type, which is always `vector_store.file_batch`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        #   `completed`, `cancelled` or `failed`.
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The ID of the
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        #   that the [File](https://platform.openai.com/docs/api-reference/files) is
        #   attached to.
        sig { returns(String) }
        def vector_store_id
        end

        sig { params(_: String).returns(String) }
        def vector_store_id=(_)
        end

        # A batch of files attached to a vector store.
        sig do
          params(
            id: String,
            created_at: Integer,
            file_counts: OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts,
            status: Symbol,
            vector_store_id: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, created_at:, file_counts:, status:, vector_store_id:, object: :"vector_store.files_batch")
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                file_counts: OpenAI::Models::VectorStores::VectorStoreFileBatch::FileCounts,
                object: Symbol,
                status: Symbol,
                vector_store_id: String
              }
            )
        end
        def to_hash
        end

        class FileCounts < OpenAI::BaseModel
          # The number of files that where cancelled.
          sig { returns(Integer) }
          def cancelled
          end

          sig { params(_: Integer).returns(Integer) }
          def cancelled=(_)
          end

          # The number of files that have been processed.
          sig { returns(Integer) }
          def completed
          end

          sig { params(_: Integer).returns(Integer) }
          def completed=(_)
          end

          # The number of files that have failed to process.
          sig { returns(Integer) }
          def failed
          end

          sig { params(_: Integer).returns(Integer) }
          def failed=(_)
          end

          # The number of files that are currently being processed.
          sig { returns(Integer) }
          def in_progress
          end

          sig { params(_: Integer).returns(Integer) }
          def in_progress=(_)
          end

          # The total number of files.
          sig { returns(Integer) }
          def total
          end

          sig { params(_: Integer).returns(Integer) }
          def total=(_)
          end

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
          def self.new(cancelled:, completed:, failed:, in_progress:, total:)
          end

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
          def to_hash
          end
        end

        # The status of the vector store files batch, which can be either `in_progress`,
        #   `completed`, `cancelled` or `failed`.
        class Status < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          CANCELLED = :cancelled
          FAILED = :failed

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
