# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Create a vector store file by attaching a
        #   [File](https://platform.openai.com/docs/api-reference/files) to a
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File.
        #
        # @param params [OpenAI::Models::VectorStores::FileCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :file_id A [File](https://platform.openai.com/docs/api-reference/files) ID that the
        #     vector store should use. Useful for tools like `file_search` that can access
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
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def create(vector_store_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%0s/files", vector_store_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Retrieves a vector store file.
        #
        # @param file_id [String] The ID of the file being retrieved.
        #
        # @param params [OpenAI::Models::VectorStores::FileRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id The ID of the vector store that the file belongs to.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def retrieve(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileRetrieveParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :get,
            path: ["vector_stores/%0s/files/%1s", vector_store_id, file_id],
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Update attributes on a vector store file.
        #
        # @param file_id [String] Path param: The ID of the file to update attributes.
        #
        # @param params [OpenAI::Models::VectorStores::FileUpdateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id Path param: The ID of the vector store the file belongs to.
        #
        #   @option params [Hash{Symbol=>String, Float, Boolean}, nil] :attributes Body param: Set of 16 key-value pairs that can be attached to an object. This
        #     can be useful for storing additional information about the object in a
        #     structured format, and querying for objects via API or the dashboard. Keys are
        #     strings with a maximum length of 64 characters. Values are strings with a
        #     maximum length of 512 characters, booleans, or numbers.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def update(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileUpdateParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :post,
            path: ["vector_stores/%0s/files/%1s", vector_store_id, file_id],
            body: parsed,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Returns a list of vector store files.
        #
        # @param vector_store_id [String] The ID of the vector store that the files belong to.
        #
        # @param params [OpenAI::Models::VectorStores::FileListParams, Hash{Symbol=>Object}] .
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
        #   @option params [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter] :filter Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
        #
        #   @option params [Symbol, OpenAI::Models::VectorStores::FileListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #     order and `desc` for descending order.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        def list(vector_store_id, params = {})
          parsed, options = OpenAI::Models::VectorStores::FileListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["vector_stores/%0s/files", vector_store_id],
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::VectorStores::VectorStoreFile,
            options: options
          )
        end

        # Delete a vector store file. This will remove the file from the vector store but
        #   the file itself will not be deleted. To delete the file, use the
        #   [delete file](https://platform.openai.com/docs/api-reference/files/delete)
        #   endpoint.
        #
        # @param file_id [String] The ID of the file to delete.
        #
        # @param params [OpenAI::Models::VectorStores::FileDeleteParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id The ID of the vector store that the file belongs to.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileDeleted]
        def delete(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileDeleteParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :delete,
            path: ["vector_stores/%0s/files/%1s", vector_store_id, file_id],
            model: OpenAI::Models::VectorStores::VectorStoreFileDeleted,
            options: options
          )
        end

        # Retrieve the parsed contents of a vector store file.
        #
        # @param file_id [String] The ID of the file within the vector store.
        #
        # @param params [OpenAI::Models::VectorStores::FileContentParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :vector_store_id The ID of the vector store.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Page<OpenAI::Models::VectorStores::FileContentResponse>]
        def content(file_id, params)
          parsed, options = OpenAI::Models::VectorStores::FileContentParams.dump_request(params)
          vector_store_id = parsed.delete(:vector_store_id) do
            raise ArgumentError.new("missing required path argument #{_1}")
          end
          @client.request(
            method: :get,
            path: ["vector_stores/%0s/files/%1s/content", vector_store_id, file_id],
            page: OpenAI::Page,
            model: OpenAI::Models::VectorStores::FileContentResponse,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
