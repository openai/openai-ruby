# frozen_string_literal: true

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::VectorStores::FileBatchCreateParams} for more details.
        #
        # Create a vector store file batch.
        #
        # @overload create(vector_store_id, attributes: nil, chunking_strategy: nil, file_ids: nil, files: nil, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File Batch.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #
        # @param file_ids [Array<String>] A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        #
        # @param files [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>] A list of objects that each include a `file_id` plus optional `attributes` or `c
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCreateParams
        def create(vector_store_id, params = {})
          parsed, options = OpenAI::VectorStores::FileBatchCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches", vector_store_id],
            body: parsed,
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {
              **options,
              extra_headers: OpenAI::Internal::Util.normalized_headers(
                {"OpenAI-Beta" => "assistants=v2"},
                options[:extra_headers].to_h
              )
            }
          )
        end

        # Create a vector store file batch and wait for processing to finish.
        #
        # The returned batch may have a `failed` or `cancelled` status; callers should
        # inspect its status and file counts. Polling intervals and the overall timeout
        # are in seconds. Finite timeouts include authentication and request replay
        # time and disable transport retries so the deadline remains strict. Set
        # `timeout` to `nil` to wait indefinitely and retain configured transport retries.
        #
        # @overload create_and_poll(vector_store_id, attributes: nil, chunking_strategy: nil, file_ids: nil, files: nil, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File Batch.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Attributes to apply to each file in `file_ids`.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the files.
        #
        # @param file_ids [Array<String>] File IDs to add to the vector store.
        #
        # @param files [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>] File IDs with per-file attributes or chunking strategies.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the batch. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        def create_and_poll(
          vector_store_id,
          attributes: nil,
          chunking_strategy: nil,
          file_ids: nil,
          files: nil,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          OpenAI::Internal::Poller.validate!(poll_interval: poll_interval, timeout: timeout)

          params = {request_options: request_options}
          params[:attributes] = attributes unless attributes.nil?
          params[:chunking_strategy] = chunking_strategy unless chunking_strategy.nil?
          params[:file_ids] = file_ids unless file_ids.nil?
          params[:files] = files unless files.nil?
          batch = create(vector_store_id, params)
          poll(
            batch.id,
            vector_store_id: vector_store_id,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
          )
        end

        # Retrieves a vector store file batch.
        #
        # @overload retrieve(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String] The ID of the file batch being retrieved.
        #
        # @param vector_store_id [String] The ID of the vector store that the file batch belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchRetrieveParams
        def retrieve(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchRetrieveParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s", vector_store_id, batch_id],
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Cancel a vector store file batch. This attempts to cancel the processing of
        # files in this batch as soon as possible.
        #
        # @overload cancel(batch_id, vector_store_id:, request_options: {})
        #
        # @param batch_id [String] The ID of the file batch to cancel.
        #
        # @param vector_store_id [String] The ID of the vector store that the file batch belongs to.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        #
        # @see OpenAI::Models::VectorStores::FileBatchCancelParams
        def cancel(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchCancelParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :post,
            path: ["vector_stores/%1$s/file_batches/%2$s/cancel", vector_store_id, batch_id],
            model: OpenAI::VectorStores::VectorStoreFileBatch,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::VectorStores::FileBatchListFilesParams} for more details.
        #
        # Returns a list of vector store files in a batch.
        #
        # @overload list_files(batch_id, vector_store_id:, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #
        # @param batch_id [String] Path param: The ID of the file batch that the files belong to.
        #
        # @param vector_store_id [String] Path param: The ID of the vector store that the files belong to.
        #
        # @param after [String] Query param: A cursor for use in pagination. `after` is an object ID that define
        #
        # @param before [String] Query param: A cursor for use in pagination. `before` is an object ID that defin
        #
        # @param filter [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter] Query param: Filter by file status. One of `in_progress`, `completed`, `failed`,
        #
        # @param limit [Integer] Query param: A limit on the number of objects to be returned. Limit can range be
        #
        # @param order [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order] Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::VectorStores::VectorStoreFile>]
        #
        # @see OpenAI::Models::VectorStores::FileBatchListFilesParams
        def list_files(batch_id, params)
          parsed, options = OpenAI::VectorStores::FileBatchListFilesParams.dump_request(params)
          vector_store_id =
            parsed.delete(:vector_store_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: ["vector_stores/%1$s/file_batches/%2$s/files", vector_store_id, batch_id],
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::VectorStores::VectorStoreFile,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Wait for a vector store file batch to finish processing.
        #
        # The returned batch may have a `failed` or `cancelled` status; callers should
        # inspect its status and file counts. Polling intervals and the overall timeout
        # are in seconds. Set `timeout` to `nil` to wait indefinitely.
        #
        # @overload poll(batch_id, vector_store_id:, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param batch_id [String] The ID of the file batch being retrieved.
        #
        # @param vector_store_id [String] The ID of the vector store that the file batch belongs to.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the batch. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        def poll(
          batch_id,
          vector_store_id:,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          poller = OpenAI::Internal::Poller.new(
            operation: "vector store file batch #{batch_id}",
            poll_interval: poll_interval,
            timeout: timeout
          )
          batch = nil

          begin
            loop do
              batch = poller.request(
                request_options,
                extra_headers: {"OpenAI-Beta" => "assistants=v2"},
                resource: batch
              ) do |options|
                retrieve(batch_id, vector_store_id: vector_store_id, request_options: options)
              end
              case batch.status
              when OpenAI::VectorStores::VectorStoreFileBatch::Status::IN_PROGRESS
                poller.wait(batch)
              when OpenAI::VectorStores::VectorStoreFileBatch::Status::COMPLETED,
                   OpenAI::VectorStores::VectorStoreFileBatch::Status::FAILED,
                   OpenAI::VectorStores::VectorStoreFileBatch::Status::CANCELLED
                return batch
              else
                raise OpenAI::Errors::PollingError,
                      "Unexpected status while waiting for vector store file batch " \
                      "#{batch_id}: #{batch.status.inspect}"
              end
            end
          rescue OpenAI::Errors::APITimeoutError
            poller.check_deadline!(batch)
            raise
          end
        end

        # Upload files concurrently, create a vector store file batch, and wait for
        # processing to finish.
        #
        # Existing file IDs can be included alongside new uploads. Upload concurrency is
        # bounded and defaults to 5. Set `max_concurrency` to 1 for sequential uploads.
        # Inputs are enumerated before requests begin so the 2,000-file API limit can be
        # checked without orphaning uploads. IO streams must remain open until this method returns.
        #
        # @overload upload_and_poll(vector_store_id, files:, file_ids: [], max_concurrency: 5, attributes: nil, chunking_strategy: nil, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File Batch.
        #
        # @param files [Enumerable<Pathname, StringIO, IO, String, OpenAI::FilePart>] Files to upload. IO streams
        #   yielded by an enumerable must remain open until this method returns.
        #
        # @param file_ids [Array<String>] IDs of files that have already been uploaded.
        #
        # @param max_concurrency [Integer] Maximum number of simultaneous file uploads.
        #
        # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Attributes to apply to every file.
        #
        # @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the files.
        #
        # @param poll_interval [Integer, Float, nil] How often to retrieve the batch. When omitted, the SDK honors the server's
        #   polling hint and otherwise waits 5 seconds.
        #
        # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
        #   indefinitely.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] Applied to every upload and to the
        #   batch creation and polling requests.
        #
        # @raise [ArgumentError, OpenAI::Errors::PollingError]
        # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
        def upload_and_poll(
          vector_store_id,
          files:,
          file_ids: [],
          max_concurrency: 5,
          attributes: nil,
          chunking_strategy: nil,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
          OpenAI::Internal::Poller.validate!(poll_interval: poll_interval, timeout: timeout)

          max_files = OpenAI::Internal::VectorStoreFileUploader::MAX_FILES_PER_BATCH
          if file_ids.length > max_files
            raise ArgumentError, "`file_ids` cannot contain more than #{max_files} entries"
          end

          uploaded = OpenAI::Internal::VectorStoreFileUploader.new(
            client: @client,
            max_concurrency: max_concurrency,
            request_options: request_options
          ).upload(files, max_files: max_files - file_ids.length)

          if uploaded.empty?
            raise ArgumentError,
                  "No `files` provided. Use `create_and_poll` when all files are already uploaded."
          end

          create_and_poll(
            vector_store_id,
            file_ids: [*file_ids, *uploaded.map(&:id)],
            attributes: attributes,
            chunking_strategy: chunking_strategy,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
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
