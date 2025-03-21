# typed: strong

module OpenAI
  module Models
    module VectorStores
      class VectorStoreFile < OpenAI::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the vector store file was created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        # The last error associated with this vector store file. Will be `null` if there
        #   are no errors.
        sig { returns(T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError)) }
        def last_error
        end

        sig do
          params(
            _: T.nilable(T.any(OpenAI::Models::VectorStores::VectorStoreFile::LastError, OpenAI::Util::AnyHash))
          )
            .returns(T.nilable(T.any(OpenAI::Models::VectorStores::VectorStoreFile::LastError, OpenAI::Util::AnyHash)))
        end
        def last_error=(_)
        end

        # The object type, which is always `vector_store.file`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The status of the vector store file, which can be either `in_progress`,
        #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        #   vector store file is ready for use.
        sig { returns(OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol) }
        def status
        end

        sig do
          params(_: OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)
            .returns(OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol)
        end
        def status=(_)
        end

        # The total vector store usage in bytes. Note that this may be different from the
        #   original file size.
        sig { returns(Integer) }
        def usage_bytes
        end

        sig { params(_: Integer).returns(Integer) }
        def usage_bytes=(_)
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

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
        def attributes
        end

        sig do
          params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
            .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        def attributes=(_)
        end

        # The strategy used to chunk the file.
        sig do
          returns(
            T.nilable(
              T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
            )
          )
        end
        def chunking_strategy
        end

        sig do
          params(
            _: T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
          )
            .returns(
              T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
            )
        end
        def chunking_strategy=(_)
        end

        # A list of files attached to a vector store.
        sig do
          params(
            id: String,
            created_at: Integer,
            last_error: T.nilable(T.any(OpenAI::Models::VectorStores::VectorStoreFile::LastError, OpenAI::Util::AnyHash)),
            status: OpenAI::Models::VectorStores::VectorStoreFile::Status::TaggedSymbol,
            usage_bytes: Integer,
            vector_store_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject),
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
          def code
          end

          sig do
            params(_: OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol)
              .returns(OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol)
          end
          def code=(_)
          end

          # A human-readable description of the error.
          sig { returns(String) }
          def message
          end

          sig { params(_: String).returns(String) }
          def message=(_)
          end

          # The last error associated with this vector store file. Will be `null` if there
          #   are no errors.
          sig do
            params(
              code: OpenAI::Models::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol,
              message: String
            )
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
