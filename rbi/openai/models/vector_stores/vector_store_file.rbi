# typed: strong

module OpenAI
  module Models
    VectorStoreFile = VectorStores::VectorStoreFile

    module VectorStores
      class VectorStoreFile < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStores::VectorStoreFile,
              OpenAI::Internal::AnyHash
            )
          end

        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the vector store file was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The last error associated with this vector store file. Will be `null` if there
        # are no errors.
        sig do
          returns(T.nilable(OpenAI::VectorStores::VectorStoreFile::LastError))
        end
        attr_reader :last_error

        sig do
          params(
            last_error:
              T.nilable(
                OpenAI::VectorStores::VectorStoreFile::LastError::OrHash
              )
          ).void
        end
        attr_writer :last_error

        # The object type, which is always `vector_store.file`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The status of the vector store file, which can be either `in_progress`,
        # `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        # vector store file is ready for use.
        sig do
          returns(OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol)
        end
        attr_accessor :status

        # The total vector store usage in bytes. Note that this may be different from the
        # original file size.
        sig { returns(Integer) }
        attr_accessor :usage_bytes

        # The ID of the
        # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
        # that the [File](https://platform.openai.com/docs/api-reference/files) is
        # attached to.
        sig { returns(String) }
        attr_accessor :vector_store_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters, booleans, or numbers.
        sig do
          returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        attr_accessor :attributes

        # The strategy used to chunk the file.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::StaticFileChunkingStrategyObject,
                OpenAI::OtherFileChunkingStrategyObject
              )
            )
          )
        end
        attr_reader :chunking_strategy

        sig do
          params(
            chunking_strategy:
              T.any(
                OpenAI::StaticFileChunkingStrategyObject::OrHash,
                OpenAI::OtherFileChunkingStrategyObject::OrHash
              )
          ).void
        end
        attr_writer :chunking_strategy

        # A list of files attached to a vector store.
        sig do
          params(
            id: String,
            created_at: Integer,
            last_error:
              T.nilable(
                OpenAI::VectorStores::VectorStoreFile::LastError::OrHash
              ),
            status: OpenAI::VectorStores::VectorStoreFile::Status::OrSymbol,
            usage_bytes: Integer,
            vector_store_id: String,
            attributes:
              T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy:
              T.any(
                OpenAI::StaticFileChunkingStrategyObject::OrHash,
                OpenAI::OtherFileChunkingStrategyObject::OrHash
              ),
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The identifier, which can be referenced in API endpoints.
          id:,
          # The Unix timestamp (in seconds) for when the vector store file was created.
          created_at:,
          # The last error associated with this vector store file. Will be `null` if there
          # are no errors.
          last_error:,
          # The status of the vector store file, which can be either `in_progress`,
          # `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
          # vector store file is ready for use.
          status:,
          # The total vector store usage in bytes. Note that this may be different from the
          # original file size.
          usage_bytes:,
          # The ID of the
          # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
          # that the [File](https://platform.openai.com/docs/api-reference/files) is
          # attached to.
          vector_store_id:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters, booleans, or numbers.
          attributes: nil,
          # The strategy used to chunk the file.
          chunking_strategy: nil,
          # The object type, which is always `vector_store.file`.
          object: :"vector_store.file"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              last_error:
                T.nilable(OpenAI::VectorStores::VectorStoreFile::LastError),
              object: Symbol,
              status:
                OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol,
              usage_bytes: Integer,
              vector_store_id: String,
              attributes:
                T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
              chunking_strategy:
                T.any(
                  OpenAI::StaticFileChunkingStrategyObject,
                  OpenAI::OtherFileChunkingStrategyObject
                )
            }
          )
        end
        def to_hash
        end

        class LastError < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::VectorStores::VectorStoreFile::LastError,
                OpenAI::Internal::AnyHash
              )
            end

          # One of `server_error` or `rate_limit_exceeded`.
          sig do
            returns(
              OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol
            )
          end
          attr_accessor :code

          # A human-readable description of the error.
          sig { returns(String) }
          attr_accessor :message

          # The last error associated with this vector store file. Will be `null` if there
          # are no errors.
          sig do
            params(
              code:
                OpenAI::VectorStores::VectorStoreFile::LastError::Code::OrSymbol,
              message: String
            ).returns(T.attached_class)
          end
          def self.new(
            # One of `server_error` or `rate_limit_exceeded`.
            code:,
            # A human-readable description of the error.
            message:
          )
          end

          sig do
            override.returns(
              {
                code:
                  OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol,
                message: String
              }
            )
          end
          def to_hash
          end

          # One of `server_error` or `rate_limit_exceeded`.
          module Code
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::VectorStores::VectorStoreFile::LastError::Code
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SERVER_ERROR =
              T.let(
                :server_error,
                OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol
              )
            UNSUPPORTED_FILE =
              T.let(
                :unsupported_file,
                OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol
              )
            INVALID_FILE =
              T.let(
                :invalid_file,
                OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::VectorStores::VectorStoreFile::LastError::Code::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # The status of the vector store file, which can be either `in_progress`,
        # `completed`, `cancelled`, or `failed`. The status `completed` indicates that the
        # vector store file is ready for use.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::VectorStores::VectorStoreFile::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol
            )
          CANCELLED =
            T.let(
              :cancelled,
              OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::VectorStores::VectorStoreFile::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Attribute
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, Float, T::Boolean) }

          sig do
            override.returns(
              T::Array[
                OpenAI::VectorStores::VectorStoreFile::Attribute::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
