# typed: strong

module OpenAI
  module Models
    class VectorStore < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # The identifier, which can be referenced in API endpoints.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the vector store was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      sig { returns(OpenAI::VectorStore::FileCounts) }
      attr_reader :file_counts

      sig { params(file_counts: OpenAI::VectorStore::FileCounts::OrHash).void }
      attr_writer :file_counts

      # The Unix timestamp (in seconds) for when the vector store was last active.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :last_active_at

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the vector store.
      sig { returns(String) }
      attr_accessor :name

      # The object type, which is always `vector_store`.
      sig { returns(Symbol) }
      attr_accessor :object

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      # `completed`. A status of `completed` indicates that the vector store is ready
      # for use.
      sig { returns(OpenAI::VectorStore::Status::TaggedSymbol) }
      attr_accessor :status

      # The total number of bytes used by the files in the vector store.
      sig { returns(Integer) }
      attr_accessor :usage_bytes

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::VectorStore::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(expires_after: OpenAI::VectorStore::ExpiresAfter::OrHash).void
      end
      attr_writer :expires_after

      # The Unix timestamp (in seconds) for when the vector store will expire.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :expires_at

      # A vector store is a collection of processed files can be used by the
      # `file_search` tool.
      sig do
        params(
          id: String,
          created_at: Integer,
          file_counts: OpenAI::VectorStore::FileCounts::OrHash,
          last_active_at: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          status: OpenAI::VectorStore::Status::OrSymbol,
          usage_bytes: Integer,
          expires_after: OpenAI::VectorStore::ExpiresAfter::OrHash,
          expires_at: T.nilable(Integer),
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # The identifier, which can be referenced in API endpoints.
        id:,
        # The Unix timestamp (in seconds) for when the vector store was created.
        created_at:,
        file_counts:,
        # The Unix timestamp (in seconds) for when the vector store was last active.
        last_active_at:,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata:,
        # The name of the vector store.
        name:,
        # The status of the vector store, which can be either `expired`, `in_progress`, or
        # `completed`. A status of `completed` indicates that the vector store is ready
        # for use.
        status:,
        # The total number of bytes used by the files in the vector store.
        usage_bytes:,
        # The expiration policy for a vector store.
        expires_after: nil,
        # The Unix timestamp (in seconds) for when the vector store will expire.
        expires_at: nil,
        # The object type, which is always `vector_store`.
        object: :vector_store
      )
      end

      sig do
        override.returns(
          {
            id: String,
            created_at: Integer,
            file_counts: OpenAI::VectorStore::FileCounts,
            last_active_at: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            object: Symbol,
            status: OpenAI::VectorStore::Status::TaggedSymbol,
            usage_bytes: Integer,
            expires_after: OpenAI::VectorStore::ExpiresAfter,
            expires_at: T.nilable(Integer)
          }
        )
      end
      def to_hash
      end

      class FileCounts < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
          ).returns(T.attached_class)
        end
        def self.new(
          # The number of files that were cancelled.
          cancelled:,
          # The number of files that have been successfully processed.
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

      # The status of the vector store, which can be either `expired`, `in_progress`, or
      # `completed`. A status of `completed` indicates that the vector store is ready
      # for use.
      module Status
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::VectorStore::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        EXPIRED = T.let(:expired, OpenAI::VectorStore::Status::TaggedSymbol)
        IN_PROGRESS =
          T.let(:in_progress, OpenAI::VectorStore::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::VectorStore::Status::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::VectorStore::Status::TaggedSymbol])
        end
        def self.values
        end
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `last_active_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        attr_accessor :days

        # The expiration policy for a vector store.
        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(
          # The number of days after the anchor time that the vector store will expire.
          days:,
          # Anchor timestamp after which the expiration policy applies. Supported anchors:
          # `last_active_at`.
          anchor: :last_active_at
        )
        end

        sig { override.returns({ anchor: Symbol, days: Integer }) }
        def to_hash
        end
      end
    end
  end
end
