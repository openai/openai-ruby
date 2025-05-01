# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      # @return [OpenAI::Resources::VectorStores::Files]
      attr_reader :files

      # @return [OpenAI::Resources::VectorStores::FileBatches]
      attr_reader :file_batches

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VectorStoreCreateParams} for more details.
      #
      # Create a vector store.
      #
      # @overload create(chunking_strategy: nil, expires_after: nil, file_ids: nil, metadata: nil, name: nil, request_options: {})
      #
      # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      # ...
      #
      # @param expires_after [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter] The expiration policy for a vector store.
      #
      # @param file_ids [Array<String>] A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      # ...
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      # @param name [String] The name of the vector store.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::VectorStore]
      #
      # @see OpenAI::Models::VectorStoreCreateParams
      def create(params = {})
        parsed, options = OpenAI::Models::VectorStoreCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "vector_stores",
          body: parsed,
          model: OpenAI::Models::VectorStore,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
        )
      end

      # Retrieves a vector store.
      #
      # @overload retrieve(vector_store_id, request_options: {})
      #
      # @param vector_store_id [String] The ID of the vector store to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::VectorStore]
      #
      # @see OpenAI::Models::VectorStoreRetrieveParams
      def retrieve(vector_store_id, params = {})
        @client.request(
          method: :get,
          path: ["vector_stores/%1$s", vector_store_id],
          model: OpenAI::Models::VectorStore,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VectorStoreUpdateParams} for more details.
      #
      # Modifies a vector store.
      #
      # @overload update(vector_store_id, expires_after: nil, metadata: nil, name: nil, request_options: {})
      #
      # @param vector_store_id [String] The ID of the vector store to modify.
      #
      # @param expires_after [OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, nil] The expiration policy for a vector store.
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      # @param name [String, nil] The name of the vector store.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::VectorStore]
      #
      # @see OpenAI::Models::VectorStoreUpdateParams
      def update(vector_store_id, params = {})
        parsed, options = OpenAI::Models::VectorStoreUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["vector_stores/%1$s", vector_store_id],
          body: parsed,
          model: OpenAI::Models::VectorStore,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VectorStoreListParams} for more details.
      #
      # Returns a list of vector stores.
      #
      # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
      #
      # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
      # ...
      #
      # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
      # ...
      #
      # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
      # ...
      #
      # @param order [Symbol, OpenAI::Models::VectorStoreListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
      # ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStore>]
      #
      # @see OpenAI::Models::VectorStoreListParams
      def list(params = {})
        parsed, options = OpenAI::Models::VectorStoreListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "vector_stores",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Models::VectorStore,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
        )
      end

      # Delete a vector store.
      #
      # @overload delete(vector_store_id, request_options: {})
      #
      # @param vector_store_id [String] The ID of the vector store to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::VectorStoreDeleted]
      #
      # @see OpenAI::Models::VectorStoreDeleteParams
      def delete(vector_store_id, params = {})
        @client.request(
          method: :delete,
          path: ["vector_stores/%1$s", vector_store_id],
          model: OpenAI::Models::VectorStoreDeleted,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VectorStoreSearchParams} for more details.
      #
      # Search a vector store for relevant chunks based on a query and file attributes
      # filter.
      #
      # @overload search(vector_store_id, query:, filters: nil, max_num_results: nil, ranking_options: nil, rewrite_query: nil, request_options: {})
      #
      # @param vector_store_id [String] The ID of the vector store to search.
      #
      # @param query [String, Array<String>] A query string for a search
      #
      # @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter] A filter to apply based on file attributes.
      #
      # @param max_num_results [Integer] The maximum number of results to return. This number should be between 1 and 50
      # ...
      #
      # @param ranking_options [OpenAI::Models::VectorStoreSearchParams::RankingOptions] Ranking options for search.
      #
      # @param rewrite_query [Boolean] Whether to rewrite the natural language query for vector search.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Page<OpenAI::Models::VectorStoreSearchResponse>]
      #
      # @see OpenAI::Models::VectorStoreSearchParams
      def search(vector_store_id, params)
        parsed, options = OpenAI::Models::VectorStoreSearchParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["vector_stores/%1$s/search", vector_store_id],
          body: parsed,
          page: OpenAI::Internal::Page,
          model: OpenAI::Models::VectorStoreSearchResponse,
          options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @files = OpenAI::Resources::VectorStores::Files.new(client: client)
        @file_batches = OpenAI::Resources::VectorStores::FileBatches.new(client: client)
      end
    end
  end
end
