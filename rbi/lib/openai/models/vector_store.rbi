# typed: strong

module OpenAI
  module Models
    class VectorStore < OpenAI::BaseModel
      # The identifier, which can be referenced in API endpoints.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The Unix timestamp (in seconds) for when the vector store was created.
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

      # The Unix timestamp (in seconds) for when the vector store was last active.
      sig { returns(T.nilable(Integer)) }
      def last_active_at
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def last_active_at=(_)
      end

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata
      end

      sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata=(_)
      end

      # The name of the vector store.
      sig { returns(String) }
      def name
      end

      sig { params(_: String).returns(String) }
      def name=(_)
      end

      # The object type, which is always `vector_store`.
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      #   `completed`. A status of `completed` indicates that the vector store is ready
      #   for use.
      sig { returns(OpenAI::Models::VectorStore::Status::TaggedSymbol) }
      def status
      end

      sig do
        params(_: OpenAI::Models::VectorStore::Status::TaggedSymbol)
          .returns(OpenAI::Models::VectorStore::Status::TaggedSymbol)
      end
      def status=(_)
      end

      # The total number of bytes used by the files in the vector store.
      sig { returns(Integer) }
      def usage_bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def usage_bytes=(_)
      end

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::Models::VectorStore::ExpiresAfter)) }
      def expires_after
      end

      sig { params(_: OpenAI::Models::VectorStore::ExpiresAfter).returns(OpenAI::Models::VectorStore::ExpiresAfter) }
      def expires_after=(_)
      end

      # The Unix timestamp (in seconds) for when the vector store will expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_)
      end

      # A vector store is a collection of processed files can be used by the
      #   `file_search` tool.
      sig do
        params(
          id: String,
          created_at: Integer,
          file_counts: OpenAI::Models::VectorStore::FileCounts,
          last_active_at: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          status: OpenAI::Models::VectorStore::Status::TaggedSymbol,
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
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              object: Symbol,
              status: OpenAI::Models::VectorStore::Status::TaggedSymbol,
              usage_bytes: Integer,
              expires_after: OpenAI::Models::VectorStore::ExpiresAfter,
              expires_at: T.nilable(Integer)
            }
          )
      end
      def to_hash
      end

      class FileCounts < OpenAI::BaseModel
        # The number of files that were cancelled.
        sig { returns(Integer) }
        def cancelled
        end

        sig { params(_: Integer).returns(Integer) }
        def cancelled=(_)
        end

        # The number of files that have been successfully processed.
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

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      #   `completed`. A status of `completed` indicates that the vector store is ready
      #   for use.
      module Status
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStore::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::VectorStore::Status::TaggedSymbol) }

        EXPIRED = T.let(:expired, OpenAI::Models::VectorStore::Status::TaggedSymbol)
        IN_PROGRESS = T.let(:in_progress, OpenAI::Models::VectorStore::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Models::VectorStore::Status::TaggedSymbol)
      end

      class ExpiresAfter < OpenAI::BaseModel
        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `last_active_at`.
        sig { returns(Symbol) }
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

        # The expiration policy for a vector store.
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
