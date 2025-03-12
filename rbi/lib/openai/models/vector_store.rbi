# typed: strong

module OpenAI
  module Models
    class VectorStore < OpenAI::BaseModel
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

      sig { returns(OpenAI::Models::VectorStore::FileCounts) }
      def file_counts
      end

      sig { params(_: OpenAI::Models::VectorStore::FileCounts).returns(OpenAI::Models::VectorStore::FileCounts) }
      def file_counts=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def last_active_at
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def last_active_at=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

      sig { returns(String) }
      def name
      end

      sig { params(_: String).returns(String) }
      def name=(_)
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

      sig { returns(Integer) }
      def usage_bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def usage_bytes=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::VectorStore::ExpiresAfter)) }
      def expires_after
      end

      sig { params(_: OpenAI::Models::VectorStore::ExpiresAfter).returns(OpenAI::Models::VectorStore::ExpiresAfter) }
      def expires_after=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def expires_at
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_)
      end

      sig do
        params(
          id: String,
          created_at: Integer,
          file_counts: OpenAI::Models::VectorStore::FileCounts,
          last_active_at: T.nilable(Integer),
          metadata: T.nilable(OpenAI::Models::Metadata),
          name: String,
          status: Symbol,
          usage_bytes: Integer,
          expires_after: OpenAI::Models::VectorStore::ExpiresAfter,
          expires_at: T.nilable(Integer),
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        id:,
        created_at:,
        file_counts:,
        last_active_at:,
        metadata:,
        name:,
        status:,
        usage_bytes:,
        expires_after: nil,
        expires_at: nil,
        object: :vector_store
      )
      end

      sig do
        override
          .returns(
            {
              id: String,
              created_at: Integer,
              file_counts: OpenAI::Models::VectorStore::FileCounts,
              last_active_at: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              name: String,
              object: Symbol,
              status: Symbol,
              usage_bytes: Integer,
              expires_after: OpenAI::Models::VectorStore::ExpiresAfter,
              expires_at: T.nilable(Integer)
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

        EXPIRED = :expired
        IN_PROGRESS = :in_progress
        COMPLETED = :completed

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end

      class ExpiresAfter < OpenAI::BaseModel
        sig { returns(Symbol) }
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(days:, anchor: :last_active_at)
        end

        sig { override.returns({anchor: Symbol, days: Integer}) }
        def to_hash
        end
      end
    end
  end
end
