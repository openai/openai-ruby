# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Create a vector store file by attaching a
        # [File](https://developers.openai.com/api/reference/resources/files) to a
        # [vector store](https://developers.openai.com/api/reference/resources/vector_stores).
        #
        # @overload create(vector_store_id, file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        #
        # @param vector_store_id [String]
        #   The ID of the vector store for which to create a File.
        #
        # @param file_id [String]
        #   A [File](https://developers.openai.com/api/reference/resources/files) ID that
        #   the vector store should use. Useful for tools like `file_search` that can access
        #   files. For multi-file ingestion, we recommend
        #   [`file_batches`](https://developers.openai.com/api/reference/resources/vector_stores/subresources/file_batches/methods/create)
        #   to minimize per-vector-store write requests.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
        #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #   strategy. Only applicable if `file_ids` is non-empty.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileCreateParams
        def create(vector_store_id, params)
          parsed, options = OpenAI::VectorStores::FileCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files", vector_store_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Retrieves a vector store file.
        #
        # @overload retrieve(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        #   The ID of the file being retrieved.
        #
        # @param vector_store_id [String]
        #   The ID of the vector store that the file belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileRetrieveParams
        def retrieve(file_id, params)
          parsed, options = OpenAI::VectorStores::FileRetrieveParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Update attributes on a vector store file.
        #
        # @overload update(file_id, vector_store_id:, attributes:, request_options: {})
        #
        # @param file_id [String]
        #   Path param: The ID of the file to update attributes.
        #
        # @param vector_store_id [String]
        #   Path param: The ID of the vector store the file belongs to.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        #   Body param: Set of 16 key-value pairs that can be attached to an object. This
        #   can be useful for storing additional information about the object in a
        #   structured format, and querying for objects via API or the dashboard. Keys are
        #   strings with a maximum length of 64 characters. Values are strings with a
        #   maximum length of 512 characters, booleans, or numbers.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileUpdateParams
        def update(file_id, params)
          parsed, options = OpenAI::VectorStores::FileUpdateParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Returns a list of vector store files.
        #
        # @overload list(vector_store_id, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param vector_store_id [String]
        #   The ID of the vector store that the files belong to.
        #
        # @param after [String]
        #   A cursor for use in pagination. `after` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #   fetch the next page of the list.
        #
        # @param before [String]
        #   A cursor for use in pagination. `before` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   starting with obj_foo, your subsequent call can include before=obj_foo in order
        #   to fetch the previous page of the list.
        #
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter]
        #   Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        # @param limit [Integer]
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        # @param order [Symbol, OpenAI::Models::VectorStores::FileListParams::Order]
        #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileListParams
        def list(vector_store_id, params = {})
          parsed, options = OpenAI::VectorStores::FileListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files", vector_store_id],
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Delete a vector store file. This will remove the file from the vector store but
        # the file itself will not be deleted. To delete the file, use the
        # [delete file](https://developers.openai.com/api/reference/resources/files/methods/delete)
        # endpoint.
        #
        # @overload delete(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        #   The ID of the file to delete.
        #
        # @param vector_store_id [String]
        #   The ID of the vector store that the file belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileDeleted]
        #
        # @see OpenAI::Models::VectorStores::FileDeleteParams
        def delete(file_id, params)
          parsed, options = OpenAI::VectorStores::FileDeleteParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :delete,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::VectorStores::VectorStoreFileDeleted,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Retrieve the parsed contents of a vector store file.
        #
        # @overload content(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        #   The ID of the file within the vector store.
        #
        # @param vector_store_id [String]
        #   The ID of the vector store.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Page<OpenAI::Models::VectorStores::FileContentResponse>]
        #
        # @see OpenAI::Models::VectorStores::FileContentParams
        def content(file_id, params)
          parsed, options = OpenAI::VectorStores::FileContentParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s/content", vector_store_id, file_id],
            page: OpenAI::Internal::Page,
            model: OpenAI::Models::VectorStores::FileContentResponse,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
