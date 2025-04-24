# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::VectorStores::FileCreateParams} for more details.
        #
        # Create a vector store file by attaching a
        # [File](https://platform.openai.com/docs/api-reference/files) to a
        # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
        #
        # @overload create(vector_store_id, file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File. ...
        #
        # @param file_id [String] A [File](https://platform.openai.com/docs/api-reference/files) ID that the vecto
        # ...
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        # ...
        #
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
        # @param file_id [String] The ID of the file being retrieved.
        #
        # @param vector_store_id [String] The ID of the vector store that the file belongs to.
        #
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

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::VectorStores::FileUpdateParams} for more details.
        #
        # Update attributes on a vector store file.
        #
        # @overload update(file_id, vector_store_id:, attributes:, request_options: {})
        #
        # @param file_id [String] Path param: The ID of the file to update attributes.
        #
        # @param vector_store_id [String] Path param: The ID of the vector store the file belongs to.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
        # ...
        #
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

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::VectorStores::FileListParams} for more details.
        #
        # Returns a list of vector store files.
        #
        # @overload list(vector_store_id, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store that the files belong to.
        #
        # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
        # ...
        #
        # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
        # ...
        #
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter] Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        # ...
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
        # ...
        #
        # @param order [Symbol, OpenAI::Models::VectorStores::FileListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
        # ...
        #
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
        # the file itself will not be deleted. To delete the file, use the
        # [delete file](https://platform.openai.com/docs/api-reference/files/delete)
        # endpoint.
        #
        # @overload delete(file_id, vector_store_id:, request_options: {})
        #
        # @param file_id [String] The ID of the file to delete.
        #
        # @param vector_store_id [String] The ID of the vector store that the file belongs to.
        #
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
        # @param file_id [String] The ID of the file within the vector store.
        #
        # @param vector_store_id [String] The ID of the vector store.
        #
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
