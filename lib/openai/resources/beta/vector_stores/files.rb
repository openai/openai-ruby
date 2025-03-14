# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class VectorStores
        class Files
          # Create a vector store file by attaching a
          #   [File](https://platform.openai.com/docs/api-reference/files) to a
          #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
          #
          # @param vector_store_id [String] The ID of the vector store for which to create a File.
          #
          # @param params [OpenAI::Models::Beta::VectorStores::FileCreateParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :file_id A [File](https://platform.openai.com/docs/api-reference/files) ID that the
          #     vector store should use. Useful for tools like `file_search` that can access
          #     files.
          #
          #   @option params [OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam] :chunking_strategy The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #     strategy. Only applicable if `file_ids` is non-empty.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::VectorStores::VectorStoreFile]
          def create(vector_store_id, params)
            parsed, options = OpenAI::Models::Beta::VectorStores::FileCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["vector_stores/%0s/files", vector_store_id],
              body: parsed,
              model: OpenAI::Models::Beta::VectorStores::VectorStoreFile,
              options: options
            )
          end

          # Retrieves a vector store file.
          #
          # @param file_id [String] The ID of the file being retrieved.
          #
          # @param params [OpenAI::Models::Beta::VectorStores::FileRetrieveParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :vector_store_id The ID of the vector store that the file belongs to.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::VectorStores::VectorStoreFile]
          def retrieve(file_id, params)
            parsed, options = OpenAI::Models::Beta::VectorStores::FileRetrieveParams.dump_request(params)
            vector_store_id = parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
            @client.request(
              method: :get,
              path: ["vector_stores/%0s/files/%1s", vector_store_id, file_id],
              model: OpenAI::Models::Beta::VectorStores::VectorStoreFile,
              options: options
            )
          end

          # Returns a list of vector store files.
          #
          # @param vector_store_id [String] The ID of the vector store that the files belong to.
          #
          # @param params [OpenAI::Models::Beta::VectorStores::FileListParams, Hash{Symbol=>Object}] .
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
          #   @option params [Symbol, OpenAI::Models::Beta::VectorStores::FileListParams::Filter] :filter Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
          #
          #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
          #     100, and the default is 20.
          #
          #   @option params [Symbol, OpenAI::Models::Beta::VectorStores::FileListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #     order and `desc` for descending order.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::CursorPage<OpenAI::Models::Beta::VectorStores::VectorStoreFile>]
          def list(vector_store_id, params = {})
            parsed, options = OpenAI::Models::Beta::VectorStores::FileListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["vector_stores/%0s/files", vector_store_id],
              query: parsed,
              page: OpenAI::CursorPage,
              model: OpenAI::Models::Beta::VectorStores::VectorStoreFile,
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
          # @param params [OpenAI::Models::Beta::VectorStores::FileDeleteParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :vector_store_id The ID of the vector store that the file belongs to.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::VectorStores::VectorStoreFileDeleted]
          def delete(file_id, params)
            parsed, options = OpenAI::Models::Beta::VectorStores::FileDeleteParams.dump_request(params)
            vector_store_id = parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
            @client.request(
              method: :delete,
              path: ["vector_stores/%0s/files/%1s", vector_store_id, file_id],
              model: OpenAI::Models::Beta::VectorStores::VectorStoreFileDeleted,
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
end
