# typed: strong

module OpenAI
  module Models
    class VectorStore < OpenAI::BaseModel
      # The identifier, which can be referenced in API endpoints.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the vector store was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      sig { returns(OpenAI::Models::VectorStore::FileCounts) }
      attr_reader :file_counts

      sig { params(file_counts: T.any(OpenAI::Models::VectorStore::FileCounts, OpenAI::Internal::Util::AnyHash)).void }
      attr_writer :file_counts

      # The Unix timestamp (in seconds) for when the vector store was last active.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :last_active_at

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the vector store.
      sig { returns(String) }
      attr_accessor :name

      # The object type, which is always `vector_store`.
      sig { returns(Symbol) }
      attr_accessor :object

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      #   `completed`. A status of `completed` indicates that the vector store is ready
      #   for use.
      sig { returns(OpenAI::Models::VectorStore::Status::TaggedSymbol) }
      attr_accessor :status

      # The total number of bytes used by the files in the vector store.
      sig { returns(Integer) }
      attr_accessor :usage_bytes

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::Models::VectorStore::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(expires_after: T.any(OpenAI::Models::VectorStore::ExpiresAfter, OpenAI::Internal::Util::AnyHash))
          .void
      end
      attr_writer :expires_after

      # The Unix timestamp (in seconds) for when the vector store will expire.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :expires_at

      # A vector store is a collection of processed files can be used by the
      #   `file_search` tool.
      sig do
        params(
          id: String,
          created_at: Integer,
          file_counts: T.any(OpenAI::Models::VectorStore::FileCounts, OpenAI::Internal::Util::AnyHash),
          last_active_at: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          status: OpenAI::Models::VectorStore::Status::OrSymbol,
          usage_bytes: Integer,
          expires_after: T.any(OpenAI::Models::VectorStore::ExpiresAfter, OpenAI::Internal::Util::AnyHash),
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
        attr_accessor :cancelled

        # The number of files that have been successfully processed.
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
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::VectorStore::Status::TaggedSymbol) }

        EXPIRED = T.let(:expired, OpenAI::Models::VectorStore::Status::TaggedSymbol)
        IN_PROGRESS = T.let(:in_progress, OpenAI::Models::VectorStore::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Models::VectorStore::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::VectorStore::Status::TaggedSymbol]) }
        def self.values
        end
      end

      class ExpiresAfter < OpenAI::BaseModel
        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `last_active_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        attr_accessor :days

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
