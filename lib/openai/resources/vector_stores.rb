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
      # @overload create(chunking_strategy: nil, expires_after: nil, file_ids: nil, metadata: nil, name: nil, request_options: {})
      #
      # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
      # @param expires_after [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter]
      # @param file_ids [Array<String>]
      # @param metadata [Hash{Symbol=>String}, nil]
      # @param name [String]
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
          options: options
        )
      end

      # Retrieves a vector store.
      #
      # @overload retrieve(vector_store_id, request_options: {})
      #
      # @param vector_store_id [String]
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
          options: params[:request_options]
        )
      end

      # Modifies a vector store.
      #
      # @overload update(vector_store_id, expires_after: nil, metadata: nil, name: nil, request_options: {})
      #
      # @param vector_store_id [String]
      # @param expires_after [OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, nil]
      # @param metadata [Hash{Symbol=>String}, nil]
      # @param name [String, nil]
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
          options: options
        )
      end

      # Returns a list of vector stores.
      #
      # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
      #
      # @param after [String]
      # @param before [String]
      # @param limit [Integer]
      # @param order [Symbol, OpenAI::Models::VectorStoreListParams::Order]
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
          options: options
        )
      end

      # Delete a vector store.
      #
      # @overload delete(vector_store_id, request_options: {})
      #
      # @param vector_store_id [String]
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
          options: params[:request_options]
        )
      end

      # Search a vector store for relevant chunks based on a query and file attributes
      # filter.
      #
      # @overload search(vector_store_id, query:, filters: nil, max_num_results: nil, ranking_options: nil, rewrite_query: nil, request_options: {})
      #
      # @param vector_store_id [String]
      # @param query [String, Array<String>]
      # @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]
      # @param max_num_results [Integer]
      # @param ranking_options [OpenAI::Models::VectorStoreSearchParams::RankingOptions]
      # @param rewrite_query [Boolean]
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
          options: options
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
