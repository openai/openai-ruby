# typed: strong

module OpenAI
  module Models
    VectorStoreFileBatch = T.type_alias { VectorStores::VectorStoreFileBatch }

    module VectorStores
      class VectorStoreFileBatch < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

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

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(String) }
        def vector_store_id
        end

        sig { params(_: String).returns(String) }
        def vector_store_id=(_)
        end

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
          sig { returns(Integer) }
          def cancelled
          end

          sig { params(_: Integer).returns(Integer) }
          def cancelled=(_)
          end

          sig { returns(Integer) }
          def completed
          end

          sig { params(_: Integer).returns(Integer) }
          def completed=(_)
          end

          sig { returns(Integer) }
          def failed
          end

          sig { params(_: Integer).returns(Integer) }
          def failed=(_)
          end

          sig { returns(Integer) }
          def in_progress
          end

          sig { params(_: Integer).returns(Integer) }
          def in_progress=(_)
          end

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
