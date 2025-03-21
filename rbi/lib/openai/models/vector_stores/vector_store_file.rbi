# typed: strong

module OpenAI
  module Models
    module VectorStores
      class VectorStoreFile < OpenAI::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the vector store file was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The last error associated with this vector store file. Will be `null` if there
        #   are no errors.
        sig { returns(T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError)) }
        attr_reader :last_error

        sig do
          params(
            last_error: T.nilable(T.any(OpenAI::Models::VectorStores::VectorStoreFile::LastError, OpenAI::Util::AnyHash))
          )
            .void
        end
        attr_writer :last_error

        # The object type, which is always `vector_store.file`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The status of the vector store file, which can be either `in_progress`,
        #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        #   vector store file is ready for use.
        sig { returns(OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol) }
        attr_accessor :status

        # The total vector store usage in bytes. Note that this may be different from the
        #   original file size.
        sig { returns(Integer) }
        attr_accessor :usage_bytes

        # The ID of the
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        #   that the [File](https://platform.openai.com/docs/api-reference/files) is
        #   attached to.
        sig { returns(String) }
        attr_accessor :vector_store_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
        attr_accessor :attributes

        # The strategy used to chunk the file.
        sig do
          returns(
            T.nilable(
              T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
            )
          )
        end
        attr_reader :chunking_strategy

        sig do
          params(
            chunking_strategy: T.any(
              OpenAI::Models::StaticFileChunkingStrategyObject,
              OpenAI::Util::AnyHash,
              OpenAI::Models::OtherFileChunkingStrategyObject
            )
          )
            .void
        end
        attr_writer :chunking_strategy

        # A list of files attached to a vector store.
        sig do
          params(
            id: String,
            created_at: Integer,
            last_error: T.nilable(T.any(OpenAI::Models::VectorStores::VectorStoreFile::LastError, OpenAI::Util::AnyHash)),
            status: OpenAI::Models::VectorStores::VectorStoreFile::Status::OrSymbol,
            usage_bytes: Integer,
            vector_store_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::StaticFileChunkingStrategyObject,
              OpenAI::Util::AnyHash,
              OpenAI::Models::OtherFileChunkingStrategyObject
            ),
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          last_error:,
          status:,
          usage_bytes:,
          vector_store_id:,
          attributes: nil,
          chunking_strategy: nil,
          object: :"vector_store.file"
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                last_error: T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError),
                object: Symbol,
                status: OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol,
                usage_bytes: Integer,
                vector_store_id: String,
                attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
                chunking_strategy: T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
              }
            )
        end
        def to_hash
        end

        class LastError < OpenAI::BaseModel
          # One of `server_error` or `rate_limit_exceeded`.
          sig { returns(OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol) }
          attr_accessor :code

          # A human-readable description of the error.
          sig { returns(String) }
          attr_accessor :message

          # The last error associated with this vector store file. Will be `null` if there
          #   are no errors.
          sig do
            params(code: OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::OrSymbol, message: String)
              .returns(T.attached_class)
          end
          def self.new(code:, message:)
          end

          sig do
            override
              .returns(
                {code: OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol, message: String}
              )
          end
          def to_hash
          end

          # One of `server_error` or `rate_limit_exceeded`.
          module Code
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol) }

            SERVER_ERROR =
              T.let(:server_error, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol)
            UNSUPPORTED_FILE =
              T.let(:unsupported_file, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol)
            INVALID_FILE =
              T.let(:invalid_file, OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol]) }
              def values
              end
            end
          end
        end

        # The status of the vector store file, which can be either `in_progress`,
        #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        #   vector store file is ready for use.
        module Status
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::VectorStoreFile::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol]) }
            def values
            end
          end
        end

        module Attribute
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }

          class << self
            sig { override.returns([String, Float, T::Boolean]) }
            def variants
            end
          end
        end
      end
    end

    VectorStoreFile = VectorStores::VectorStoreFile
  end
end
