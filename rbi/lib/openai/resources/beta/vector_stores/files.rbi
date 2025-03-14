# typed: strong

module OpenAI
  module Resources
    class Beta
      class VectorStores
        class Files
          # Create a vector store file by attaching a
          #   [File](https://platform.openai.com/docs/api-reference/files) to a
          #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
          sig do
            params(
              vector_store_id: String,
              file_id: String,
              chunking_strategy: T.any(
                OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
              ),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::VectorStores::VectorStoreFile)
          end
          def create(
            # The ID of the vector store for which to create a File.
            vector_store_id,
            # A [File](https://platform.openai.com/docs/api-reference/files) ID that the
            #   vector store should use. Useful for tools like `file_search` that can access
            #   files.
            file_id:,
            # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
            #   strategy. Only applicable if `file_ids` is non-empty.
            chunking_strategy: nil,
            request_options: {}
          )
          end

          # Retrieves a vector store file.
          sig do
            params(
              file_id: String,
              vector_store_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::VectorStores::VectorStoreFile)
          end
          def retrieve(
            # The ID of the file being retrieved.
            file_id,
            # The ID of the vector store that the file belongs to.
            vector_store_id:,
            request_options: {}
          )
          end

          # Returns a list of vector store files.
          sig do
            params(
              vector_store_id: String,
              after: String,
              before: String,
              filter: Symbol,
              limit: Integer,
              order: Symbol,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::CursorPage[OpenAI::Models::Beta::VectorStores::VectorStoreFile])
          end
          def list(
            # The ID of the vector store that the files belong to.
            vector_store_id,
            # A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            after: nil,
            # A cursor for use in pagination. `before` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   starting with obj_foo, your subsequent call can include before=obj_foo in order
            #   to fetch the previous page of the list.
            before: nil,
            # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
            filter: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            limit: nil,
            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
            order: nil,
            request_options: {}
          )
          end

          # Delete a vector store file. This will remove the file from the vector store but
          #   the file itself will not be deleted. To delete the file, use the
          #   [delete file](https://platform.openai.com/docs/api-reference/files/delete)
          #   endpoint.
          sig do
            params(
              file_id: String,
              vector_store_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::VectorStores::VectorStoreFileDeleted)
          end
          def delete(
            # The ID of the file to delete.
            file_id,
            # The ID of the vector store that the file belongs to.
            vector_store_id:,
            request_options: {}
          )
          end

          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
