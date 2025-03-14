# typed: strong

module OpenAI
  module Models
    VectorStoreFile = T.type_alias { VectorStores::VectorStoreFile }

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
          params(_: T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError))
            .returns(T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError))
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
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
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
            last_error: T.nilable(OpenAI::Models::VectorStores::VectorStoreFile::LastError),
            status: Symbol,
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
                status: Symbol,
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
          sig { returns(Symbol) }
          def code
          end

          sig { params(_: Symbol).returns(Symbol) }
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
          sig { params(code: Symbol, message: String).returns(T.attached_class) }
          def self.new(code:, message:)
          end

          sig { override.returns({code: Symbol, message: String}) }
          def to_hash
          end

          # One of `server_error` or `rate_limit_exceeded`.
          class Code < OpenAI::Enum
            abstract!

            SERVER_ERROR = :server_error
            UNSUPPORTED_FILE = :unsupported_file
            INVALID_FILE = :invalid_file

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end

        # The status of the vector store file, which can be either `in_progress`,
        #   `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        #   vector store file is ready for use.
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

        class Attribute < OpenAI::Union
          abstract!

          class << self
            # @api private
            sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
            private def variants
            end
          end
        end
      end
    end
  end
end
