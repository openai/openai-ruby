# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Create a vector store file by attaching a
        #   [File](https://platform.openai.com/docs/api-reference/files) to a
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
        #
        # @overload create(vector_store_id, file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        #
        # @param vector_store_id [String]
        # @param file_id [String]
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileCreateParams
        def create(vector_store_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files", vector_store_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Retrieves a vector store file.
        #
        # @overload retrieve(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        # @param vector_store_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileRetrieveParams
        def retrieve(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileRetrieveParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Update attributes on a vector store file.
        #
        # @overload update(file_id, vector_store_id:, attributes:, request_options: {})
        #
        # @param file_id [String]
        # @param vector_store_id [String]
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileUpdateParams
        def update(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileUpdateParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Returns a list of vector store files.
        #
        # @overload list(vector_store_id, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param vector_store_id [String]
        # @param after [String]
        # @param before [String]
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter]
        # @param limit [Integer]
        # @param order [Symbol, OpenAI::Models::VectorStores::FileListParams::Order]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileListParams
        def list(vector_store_id, params = {})
          parsed, options = OpenAI::Models::VectorStores::FileListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files", vector_store_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Delete a vector store file. This will remove the file from the vector store but
        #   the file itself will not be deleted. To delete the file, use the
        #   [delete file](https://platform.openai.com/docs/api-reference/files/delete)
        #   endpoint.
        #
        # @overload delete(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        # @param vector_store_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileDeleted]
        #
        # @see OpenAI::Models::VectorStores::FileDeleteParams
        def delete(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileDeleteParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileDeleted,
            options: options
          )
        end

        # Retrieve the parsed contents of a vector store file.
        #
        # @overload content(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String]
        # @param vector_store_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Page<OpenAI::Models::VectorStores::FileContentResponse>]
        #
        # @see OpenAI::Models::VectorStores::FileContentParams
        def content(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileContentParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s/content", vector_store_id, file_id],
            page: OpenAI::Internal::Page,
            model: OpenAI::Models::VectorStores::FileContentResponse,
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
