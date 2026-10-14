# frozen_string_literal: true

require_relative "../../resources/vector_stores/file_batches"
require_relative "../resource_polling"

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
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
          OpenAI::Helpers::ResourcePolling.poll_vector_store_file_batch(
            self,
            batch_id,
            vector_store_id: vector_store_id,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
          )
        end

        # Upload files concurrently, create a vector store file batch, and wait for
        # processing to finish.
        #
        # Existing file IDs can be included alongside new uploads. Upload concurrency is
        # bounded and defaults to 5. Set `max_concurrency` to 1 for sequential uploads.
        # Inputs are enumerated before requests begin so the 2,000-file API limit can be
        # checked without orphaning uploads. Stream-backed inputs are safely spooled during
        # enumeration, including IO objects yielded from block-scoped enumerators.
        #
        # @overload upload_and_poll(vector_store_id, files:, file_ids: [], max_concurrency: 5, attributes: nil, chunking_strategy: nil, poll_interval: nil, timeout: 1800.0, request_options: {})
        #
        # @param vector_store_id [String] The ID of the vector store for which to create a File Batch.
        #
        # @param files [Enumerable<Pathname, StringIO, IO, String, OpenAI::FilePart>] Files to upload.
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
        #   batch creation and polling requests. Idempotency keys are scoped to each
        #   upload and the batch creation.
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
          request_options_scope = OpenAI::Internal::RequestOptionsScope.new(request_options)

          max_files = OpenAI::Internal::VectorStoreFileUploader::MAX_FILES_PER_BATCH
          if file_ids.length > max_files
            raise ArgumentError, "`file_ids` cannot contain more than #{max_files} entries"
          end

          uploaded = OpenAI::Internal::VectorStoreFileUploader
            .new(
              client: @client,
              max_concurrency: max_concurrency,
              request_options: request_options
            )
            .upload(files, max_files: max_files - file_ids.length)

          if uploaded.empty?
            raise(
              ArgumentError,
              "No `files` provided. Use `create_and_poll` when all files are already uploaded."
            )
          end

          create_and_poll(
            vector_store_id,
            file_ids: [*file_ids, *uploaded.map(&:id)],
            attributes: attributes,
            chunking_strategy: chunking_strategy,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options_scope.child("file-batch")
          )
        end
      end
    end
  end
end
