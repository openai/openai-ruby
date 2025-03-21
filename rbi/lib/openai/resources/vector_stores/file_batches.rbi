# typed: strong

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Create a vector store file batch.
        sig do
          params(
            vector_store_id: String,
            file_ids: T::Array[String],
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            ),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def create(
          # The ID of the vector store for which to create a File Batch.
          vector_store_id,
          # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
          #   the vector store should use. Useful for tools like `file_search` that can access
          #   files.
          file_ids:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard. Keys are strings with a maximum
          #   length of 64 characters. Values are strings with a maximum length of 512
          #   characters, booleans, or numbers.
          attributes: nil,
          # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #   strategy. Only applicable if `file_ids` is non-empty.
          chunking_strategy: nil,
          request_options: {}
        )
        end

        # Retrieves a vector store file batch.
        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def retrieve(
          # The ID of the file batch being retrieved.
          batch_id,
          # The ID of the vector store that the file batch belongs to.
          vector_store_id:,
          request_options: {}
        )
        end

        # Cancel a vector store file batch. This attempts to cancel the processing of
        #   files in this batch as soon as possible.
        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def cancel(
          # The ID of the file batch to cancel.
          batch_id,
          # The ID of the vector store that the file batch belongs to.
          vector_store_id:,
          request_options: {}
        )
        end

        # Returns a list of vector store files in a batch.
        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            after: String,
            before: String,
            filter: OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol,
            limit: Integer,
            order: OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::VectorStores::VectorStoreFile])
        end
        def list_files(
          # Path param: The ID of the file batch that the files belong to.
          batch_id,
          # Path param: The ID of the vector store that the files belong to.
          vector_store_id:,
          # Query param: A cursor for use in pagination. `after` is an object ID that
          #   defines your place in the list. For instance, if you make a list request and
          #   receive 100 objects, ending with obj_foo, your subsequent call can include
          #   after=obj_foo in order to fetch the next page of the list.
          after: nil,
          # Query param: A cursor for use in pagination. `before` is an object ID that
          #   defines your place in the list. For instance, if you make a list request and
          #   receive 100 objects, starting with obj_foo, your subsequent call can include
          #   before=obj_foo in order to fetch the previous page of the list.
          before: nil,
          # Query param: Filter by file status. One of `in_progress`, `completed`, `failed`,
          #   `cancelled`.
          filter: nil,
          # Query param: A limit on the number of objects to be returned. Limit can range
          #   between 1 and 100, and the default is 20.
          limit: nil,
          # Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
          #   ascending order and `desc` for descending order.
          order: nil,
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
