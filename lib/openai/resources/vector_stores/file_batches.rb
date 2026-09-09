# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Create a vector store file batch.
        #
        # @overload create(vector_store_id, attributes: nil, chunking_strategy: nil, file_ids: nil, files: nil, request_options: {})
        #
        # @param vector_store_id [String]
        #   The ID of the vector store for which to create a File Batch.
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
        # @param file_ids [Array<String>]
        #   A list of [File](https://developers.openai.com/api/reference/resources/files)
        #   IDs that the vector store should use. Useful for tools like `file_search` that
        #   can access files. If `attributes` or `chunking_strategy` are provided, they will
        #   be applied to all files in the batch. The maximum batch size is 2000 files. This
        #   endpoint is recommended for multi-file ingestion and helps reduce
        #   per-vector-store write request pressure. Mutually exclusive with `files`.
        #
        # @param files [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>]
        #   A list of objects that each include a `file_id` plus optional `attributes` or
        #   `chunking_strategy`. Use this when you need to override metadata for specific
        #   files. The global `attributes` or `chunking_strategy` will be ignored and must
        #   be specified for each file. The maximum batch size is 2000 files. This endpoint
        #   is recommended for multi-file ingestion and helps reduce per-vector-store write
        #   request pressure. Mutually exclusive with `file_ids`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCreateParams
        def create(vector_store_id, params = {})
          parsed, options = OpenAI::VectorStores::FileBatchCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches", vector_store_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Retrieves a vector store file batch.
        #
        # @overload retrieve(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String]
        #   The ID of the file batch being retrieved.
        #
        # @param vector_store_id [String]
        #   The ID of the vector store that the file batch belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchRetrieveParams
        def retrieve(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchRetrieveParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s", vector_store_id, batch_id],
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Cancel a vector store file batch. This attempts to cancel the processing of
        # files in this batch as soon as possible.
        #
        # @overload cancel(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String]
        #   The ID of the file batch to cancel.
        #
        # @param vector_store_id [String]
        #   The ID of the vector store that the file batch belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCancelParams
        def cancel(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchCancelParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches/%2$s/cancel", vector_store_id, batch_id],
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Returns a list of vector store files in a batch.
        #
        # @overload list_files(batch_id, vector_store_id:, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param batch_id [String]
        #   Path param: The ID of the file batch that the files belong to.
        #
        # @param vector_store_id [String]
        #   Path param: The ID of the vector store that the files belong to.
        #
        # @param after [String]
        #   Query param: A cursor for use in pagination. `after` is an object ID that
        #   defines your place in the list. For instance, if you make a list request and
        #   receive 100 objects, ending with obj_foo, your subsequent call can include
        #   after=obj_foo in order to fetch the next page of the list.
        #
        # @param before [String]
        #   Query param: A cursor for use in pagination. `before` is an object ID that
        #   defines your place in the list. For instance, if you make a list request and
        #   receive 100 objects, starting with obj_foo, your subsequent call can include
        #   before=obj_foo in order to fetch the previous page of the list.
        #
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter]
        #   Query param: Filter by file status. One of `in_progress`, `completed`, `failed`,
        #   `cancelled`.
        #
        # @param limit [Integer]
        #   Query param: A limit on the number of objects to be returned. Limit can range
        #   between 1 and 100, and the default is 20.
        #
        # @param order [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order]
        #   Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
        #   ascending order and `desc` for descending order.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileBatchListFilesParams
        def list_files(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchListFilesParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end

          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s/files", vector_store_id, batch_id],
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::VectorStores::VectorStoreFile,
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
