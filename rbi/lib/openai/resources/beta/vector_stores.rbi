# typed: strong

module OpenAI
  module Resources
    class Beta
      class VectorStores
        sig { returns(OpenAI::Resources::Beta::VectorStores::Files) }
        def files
        end

        sig { returns(OpenAI::Resources::Beta::VectorStores::FileBatches) }
        def file_batches
        end

        # Create a vector store.
        sig do
          params(
            chunking_strategy: T.any(
              OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
              OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
            ),
            expires_after: OpenAI::Models::Beta::VectorStoreCreateParams::ExpiresAfter,
            file_ids: T::Array[String],
            metadata: T.nilable(OpenAI::Models::Metadata),
            name: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::VectorStore)
        end
        def create(
          # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #   strategy. Only applicable if `file_ids` is non-empty.
          chunking_strategy: nil,
          # The expiration policy for a vector store.
          expires_after: nil,
          # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
          #   the vector store should use. Useful for tools like `file_search` that can access
          #   files.
          file_ids: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # The name of the vector store.
          name: nil,
          request_options: {}
        )
        end

        # Retrieves a vector store.
        sig do
          params(
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::VectorStore)
        end
        def retrieve(
          # The ID of the vector store to retrieve.
          vector_store_id,
          request_options: {}
        )
        end

        # Modifies a vector store.
        sig do
          params(
            vector_store_id: String,
            expires_after: T.nilable(OpenAI::Models::Beta::VectorStoreUpdateParams::ExpiresAfter),
            metadata: T.nilable(OpenAI::Models::Metadata),
            name: T.nilable(String),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::VectorStore)
        end
        def update(
          # The ID of the vector store to modify.
          vector_store_id,
          # The expiration policy for a vector store.
          expires_after: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # The name of the vector store.
          name: nil,
          request_options: {}
        )
        end

        # Returns a list of vector stores.
        sig do
          params(
            after: String,
            before: String,
            limit: Integer,
            order: Symbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::Beta::VectorStore])
        end
        def list(
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
          # A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          limit: nil,
          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          order: nil,
          request_options: {}
        )
        end

        # Delete a vector store.
        sig do
          params(
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::VectorStoreDeleted)
        end
        def delete(
          # The ID of the vector store to delete.
          vector_store_id,
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
