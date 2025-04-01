# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      # @return [OpenAI::Resources::VectorStores::Files]
      attr_reader :files

      # @return [OpenAI::Resources::VectorStores::FileBatches]
      attr_reader :file_batches

      # Create a vector store.
      #
      # @param params [OpenAI::Models::VectorStoreCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] :chunking_strategy The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #     strategy. Only applicable if `file_ids` is non-empty.
      #
      #   @option params [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter] :expires_after The expiration policy for a vector store.
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
      # @return [OpenAI::Models::VectorStore]
      def create(params = {})
        parsed, options = OpenAI::Models::VectorStoreCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "vector_stores",
          body: parsed,
          model: OpenAI::Models::VectorStore,
          options: options
        )
      end

      # Retrieves a vector store.
      #
      # @param vector_store_id [String] The ID of the vector store to retrieve.
      #
      # @param params [OpenAI::Models::VectorStoreRetrieveParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::VectorStore]
      def retrieve(vector_store_id, params = {})
        @client.request(
          method: :get,
          path: ["vector_stores/%1$s", vector_store_id],
          model: OpenAI::Models::VectorStore,
          options: params[:request_options]
        )
      end

      # Modifies a vector store.
      #
      # @param vector_store_id [String] The ID of the vector store to modify.
      #
      # @param params [OpenAI::Models::VectorStoreUpdateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, nil] :expires_after The expiration policy for a vector store.
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
      # @return [OpenAI::Models::VectorStore]
      def update(vector_store_id, params = {})
        parsed, options = OpenAI::Models::VectorStoreUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["vector_stores/%1$s", vector_store_id],
          body: parsed,
          model: OpenAI::Models::VectorStore,
          options: options
        )
      end

      # Returns a list of vector stores.
      #
      # @param params [OpenAI::Models::VectorStoreListParams, Hash{Symbol=>Object}] .
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
      #   @option params [Symbol, OpenAI::Models::VectorStoreListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #     order and `desc` for descending order.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::CursorPage<OpenAI::Models::VectorStore>]
      def list(params = {})
        parsed, options = OpenAI::Models::VectorStoreListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "vector_stores",
          query: parsed,
          page: OpenAI::CursorPage,
          model: OpenAI::Models::VectorStore,
          options: options
        )
      end

      # Delete a vector store.
      #
      # @param vector_store_id [String] The ID of the vector store to delete.
      #
      # @param params [OpenAI::Models::VectorStoreDeleteParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::VectorStoreDeleted]
      def delete(vector_store_id, params = {})
        @client.request(
          method: :delete,
          path: ["vector_stores/%1$s", vector_store_id],
          model: OpenAI::Models::VectorStoreDeleted,
          options: params[:request_options]
        )
      end

      # Search a vector store for relevant chunks based on a query and file attributes
      #   filter.
      #
      # @param vector_store_id [String] The ID of the vector store to search.
      #
      # @param params [OpenAI::Models::VectorStoreSearchParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String, Array<String>] :query A query string for a search
      #
      #   @option params [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter] :filters A filter to apply based on file attributes.
      #
      #   @option params [Integer] :max_num_results The maximum number of results to return. This number should be between 1 and 50
      #     inclusive.
      #
      #   @option params [OpenAI::Models::VectorStoreSearchParams::RankingOptions] :ranking_options Ranking options for search.
      #
      #   @option params [Boolean] :rewrite_query Whether to rewrite the natural language query for vector search.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Page<OpenAI::Models::VectorStoreSearchResponse>]
      def search(vector_store_id, params)
        parsed, options = OpenAI::Models::VectorStoreSearchParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["vector_stores/%1$s/search", vector_store_id],
          body: parsed,
          page: OpenAI::Page,
          model: OpenAI::Models::VectorStoreSearchResponse,
          options: options
        )
      end

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @files = OpenAI::Resources::VectorStores::Files.new(client: client)
        @file_batches = OpenAI::Resources::VectorStores::FileBatches.new(client: client)
      end
    end
  end
end
