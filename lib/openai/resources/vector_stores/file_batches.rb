# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Create a vector store file batch.
        #
        # @overload create(vector_store_id, file_ids:, attributes: nil, chunking_strategy: nil, request_options: {})
        #
        # @param vector_store_id [String]
        # @param file_ids [Array<String>]
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCreateParams
        def create(vector_store_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches", vector_store_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Retrieves a vector store file batch.
        #
        # @overload retrieve(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String]
        # @param vector_store_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchRetrieveParams
        def retrieve(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchRetrieveParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s", vector_store_id, batch_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Cancel a vector store file batch. This attempts to cancel the processing of
        #   files in this batch as soon as possible.
        #
        # @overload cancel(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String]
        # @param vector_store_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCancelParams
        def cancel(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchCancelParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches/%2$s/cancel", vector_store_id, batch_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileBatch,
            options: options
          )
        end

        # Returns a list of vector store files in a batch.
        #
        # @overload list_files(batch_id, vector_store_id:, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param batch_id [String]
        # @param vector_store_id [String]
        # @param after [String]
        # @param before [String]
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter]
        # @param limit [Integer]
        # @param order [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileBatchListFilesParams
        def list_files(batch_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileBatchListFilesParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s/files", vector_store_id, batch_id],
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
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
