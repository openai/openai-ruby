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
        # @param vector_store_id [String] The ID of the vector store for which to create a File.
        #
        # @param file_id [String] A [File](https://platform.openai.com/docs/api-reference/files) ID that the vecto
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileCreateParams
        def create(vector_store_id, params)
          parsed, options = OpenAI::VectorStores::FileCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files", vector_store_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Attach a file to a vector store and wait for processing to finish.
        #
        # The returned file may have a `failed` or `cancelled` status; callers should
        # inspect the status and `last_error`. Polling intervals and the overall timeout
        # are in seconds. Finite timeouts disable transport retries for polling
        # retrievals so the deadline remains strict. Set `timeout` to `nil` to wait
        # indefinitely and retain configured transport retries.
        #
        # @overload create_and_poll(vector_store_id, file_id:, attributes: nil, chunking_strategy: nil, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File.
        #
        # @param file_id [String] A File ID to attach to the vector store.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Attributes to attach to the vector store file.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the file. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def create_and_poll(
          vector_store_id,
          file_id:,
          attributes: nil,
          chunking_strategy: nil,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          OpenAI::Internal::Poller.validate!(poll_interval: poll_interval, timeout: timeout)

          params = {file_id: file_id, request_options: request_options}
          params[:attributes] = attributes unless attributes.nil?
          params[:chunking_strategy] = chunking_strategy unless chunking_strategy.nil?
          file = create(vector_store_id, params)
          poll(
            file.id,
            vector_store_id: vector_store_id,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
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
          parsed, options = OpenAI::VectorStores::FileRetrieveParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
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
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        #
        # @see OpenAI::Models::VectorStores::FileUpdateParams
        def update(file_id, params)
          parsed, options = OpenAI::VectorStores::FileUpdateParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
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
        #
        # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
        #
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter] Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
        #
        # @param order [Symbol, OpenAI::Models::VectorStores::FileListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileListParams
        def list(vector_store_id, params = {})
          parsed, options = OpenAI::VectorStores::FileListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files", vector_store_id],
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
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
          parsed, options = OpenAI::VectorStores::FileDeleteParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["vector_stores/%1$s/files/%2$s", vector_store_id, file_id],
            model: OpenAI::VectorStores::VectorStoreFileDeleted,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Wait for a vector store file to finish processing.
        #
        # The returned file may have a `failed` or `cancelled` status; callers should
        # inspect the status and `last_error`. Polling intervals and the overall timeout
        # are in seconds. Set `timeout` to `nil` to wait indefinitely.
        #
        # @overload poll(file_id, vector_store_id:, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param file_id [String] The ID of the file being retrieved.
        #
        # @param vector_store_id [String] The ID of the vector store that the file belongs to.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the file. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def poll(
          file_id,
          vector_store_id:,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          poller = OpenAI::Internal::Poller.new(
            operation: "vector store file #{file_id}",
            poll_interval: poll_interval,
            timeout: timeout
          )
          file = nil

          begin
            loop do
              options = poller.request_options(
                request_options,
                extra_headers: {"OpenAI-Beta" => "assistants=v2"},
                resource: file
              )
              file = retrieve(file_id, vector_store_id: vector_store_id, request_options: options)
              case file.status
              when OpenAI::VectorStores::VectorStoreFile::Status::IN_PROGRESS
                poller.wait(file)
              when OpenAI::VectorStores::VectorStoreFile::Status::COMPLETED,
                   OpenAI::VectorStores::VectorStoreFile::Status::FAILED,
                   OpenAI::VectorStores::VectorStoreFile::Status::CANCELLED
                return file
              else
                raise OpenAI::Errors::PollingError,
                      "Unexpected status while waiting for vector store file " \
                      "#{file_id}: #{file.status.inspect}"
              end
            end
          rescue OpenAI::Errors::APITimeoutError
            poller.check_deadline!(file)
            raise
          end
        end

        # Upload a file and attach it to a vector store.
        #
        # Processing continues asynchronously; use {#upload_and_poll} to wait until the
        # file is ready.
        #
        # @overload upload(vector_store_id, file:, attributes: nil, chunking_strategy: nil, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store to attach the file to.
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The file to upload.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Attributes to attach to the vector store file.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def upload(
          vector_store_id,
          file:,
          attributes: nil,
          chunking_strategy: nil,
          request_options: {}
        )
          uploaded = @client.files.create(file: file, purpose: :assistants, request_options: request_options)
          params = {file_id: uploaded.id, request_options: request_options}
          params[:attributes] = attributes unless attributes.nil?
          params[:chunking_strategy] = chunking_strategy unless chunking_strategy.nil?
          create(vector_store_id, params)
        end

        # Upload a file, attach it to a vector store, and wait for processing to
        # finish.
        #
        # The returned file may have a `failed` or `cancelled` status; callers should
        # inspect the status and `last_error`.
        #
        # @overload upload_and_poll(vector_store_id, file:, attributes: nil, chunking_strategy: nil, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store to attach the file to.
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The file to upload.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Attributes to attach to the vector store file.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the file. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] Applied to the upload, attach,
        #   and polling requests.
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def upload_and_poll(
          vector_store_id,
          file:,
          attributes: nil,
          chunking_strategy: nil,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          OpenAI::Internal::Poller.validate!(poll_interval: poll_interval, timeout: timeout)

          attached = upload(
            vector_store_id,
            file: file,
            attributes: attributes,
            chunking_strategy: chunking_strategy,
            request_options: request_options
          )
          poll(
            attached.id,
            vector_store_id: vector_store_id,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
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
          parsed, options = OpenAI::VectorStores::FileContentParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/files/%2$s/content", vector_store_id, file_id],
            page: OpenAI::Internal::Page,
            model: OpenAI::Models::VectorStores::FileContentResponse,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
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
