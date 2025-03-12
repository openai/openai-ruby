# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Create a vector store file batch.
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File Batch.
        #
        # @param params [OpenAI::Models::VectorStores::FileBatchCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [Array<String>] :file_ids A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        #     the vector store should use. Useful for tools like `file_search` that can access
        #     files.
        #
        #   @option params [Hash{Symbol=>String, Float, Boolean}, nil] :attributes Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard. Keys are strings with a maximum
        #     length of 64 characters. Values are strings with a maximum length of 512
        #     characters, booleans, or numbers.
        #
        #   @option params [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] :chunking_strategy The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #     strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        def create(vector_store_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%0s/file_batches", vector_store_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Retrieves a vector store file batch.
        #
        # @param batch_id [String] The ID of the file batch being retrieved.
        #
        # @param params [OpenAI::Models::VectorStores::FileBatchRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id The ID of the vector store that the file batch belongs to.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        def retrieve(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchRetrieveParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :get,
            path: ["vector_stores/%0s/file_batches/%1s", vector_store_id, batch_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Cancel a vector store file batch. This attempts to cancel the processing of
        #   files in this batch as soon as possible.
        #
        # @param batch_id [String] The ID of the file batch to cancel.
        #
        # @param params [OpenAI::Models::VectorStores::FileBatchCancelParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id The ID of the vector store that the file batch belongs to.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        def cancel(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchCancelParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :post,
            path: ["vector_stores/%0s/file_batches/%1s/cancel", vector_store_id, batch_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Returns a list of vector store files in a batch.
        #
        # @param batch_id [String] Path param: The ID of the file batch that the files belong to.
        #
        # @param params [OpenAI::Models::VectorStores::FileBatchListFilesParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id Path param: The ID of the vector store that the files belong to.
        #
        #   @option params [String] :after Query param: A cursor for use in pagination. `after` is an object ID that
        #     defines your place in the list. For instance, if you make a list request and
        #     receive 100 objects, ending with obj_foo, your subsequent call can include
        #     after=obj_foo in order to fetch the next page of the list.
        #
        #   @option params [String] :before Query param: A cursor for use in pagination. `before` is an object ID that
        #     defines your place in the list. For instance, if you make a list request and
        #     receive 100 objects, starting with obj_foo, your subsequent call can include
        #     before=obj_foo in order to fetch the previous page of the list.
        #
        #   @option params [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter] :filter Query param: Filter by file status. One of `in_progress`, `completed`, `failed`,
        #     `cancelled`.
        #
        #   @option params [Integer] :limit Query param: A limit on the number of objects to be returned. Limit can range
        #     between 1 and 100, and the default is 20.
        #
        #   @option params [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order] :order Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
        #     ascending order and `desc` for descending order.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        def list_files(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchListFilesParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :get,
            path: ["vector_stores/%0s/file_batches/%1s/files", vector_store_id, batch_id],
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        #
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
