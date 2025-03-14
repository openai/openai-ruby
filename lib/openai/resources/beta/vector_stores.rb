# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class VectorStores
        # @return [OpenAI::Resources::Beta::VectorStores::Files]
        attr_reader :files

        # @return [OpenAI::Resources::Beta::VectorStores::FileBatches]
        attr_reader :file_batches

        # Create a vector store.
        #
        # @param params [OpenAI::Models::Beta::VectorStoreCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam] :chunking_strategy The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #     strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @option params [OpenAI::Models::Beta::VectorStoreCreateParams::ExpiresAfter] :expires_after The expiration policy for a vector store.
        #
        #   @option params [Array<String>] :file_ids A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        #     the vector store should use. Useful for tools like `file_search` that can access
        #     files.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String] :name The name of the vector store.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::VectorStore]
        def create(params = {})
          parsed, options = OpenAI::Models::Beta::VectorStoreCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "vector_stores",
            body: parsed,
            model: OpenAI::Models::Beta::VectorStore,
            options: options
          )
        end

        # Retrieves a vector store.
        #
        # @param vector_store_id [String] The ID of the vector store to retrieve.
        #
        # @param params [OpenAI::Models::Beta::VectorStoreRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::VectorStore]
        def retrieve(vector_store_id, params = {})
          @client.request(
            method: :get,
            path: ["vector_stores/%0s", vector_store_id],
            model: OpenAI::Models::Beta::VectorStore,
            options: params[:request_options]
          )
        end

        # Modifies a vector store.
        #
        # @param vector_store_id [String] The ID of the vector store to modify.
        #
        # @param params [OpenAI::Models::Beta::VectorStoreUpdateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::Models::Beta::VectorStoreUpdateParams::ExpiresAfter, nil] :expires_after The expiration policy for a vector store.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String, nil] :name The name of the vector store.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::VectorStore]
        def update(vector_store_id, params = {})
          parsed, options = OpenAI::Models::Beta::VectorStoreUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%0s", vector_store_id],
            body: parsed,
            model: OpenAI::Models::Beta::VectorStore,
            options: options
          )
        end

        # Returns a list of vector stores.
        #
        # @param params [OpenAI::Models::Beta::VectorStoreListParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :after A cursor for use in pagination. `after` is an object ID that defines your place
        #     in the list. For instance, if you make a list request and receive 100 objects,
        #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #     fetch the next page of the list.
        #
        #   @option params [String] :before A cursor for use in pagination. `before` is an object ID that defines your place
        #     in the list. For instance, if you make a list request and receive 100 objects,
        #     starting with obj_foo, your subsequent call can include before=obj_foo in order
        #     to fetch the previous page of the list.
        #
        #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
        #
        #   @option params [Symbol, OpenAI::Models::Beta::VectorStoreListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #     order and `desc` for descending order.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::Beta::VectorStore>]
        def list(params = {})
          parsed, options = OpenAI::Models::Beta::VectorStoreListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "vector_stores",
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::Beta::VectorStore,
            options: options
          )
        end

        # Delete a vector store.
        #
        # @param vector_store_id [String] The ID of the vector store to delete.
        #
        # @param params [OpenAI::Models::Beta::VectorStoreDeleteParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::VectorStoreDeleted]
        def delete(vector_store_id, params = {})
          @client.request(
            method: :delete,
            path: ["vector_stores/%0s", vector_store_id],
            model: OpenAI::Models::Beta::VectorStoreDeleted,
            options: params[:request_options]
          )
        end

        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @files = OpenAI::Resources::Beta::VectorStores::Files.new(client: client)
          @file_batches = OpenAI::Resources::Beta::VectorStores::FileBatches.new(client: client)
        end
      end
    end
  end
end
