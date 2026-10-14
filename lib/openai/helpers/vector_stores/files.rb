# frozen_string_literal: true

require_relative "../../resources/vector_stores/files"
require_relative "../resource_polling"

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Attach a file to a vector store and wait for processing to finish.
        #
        # The returned file may have a `failed` or `cancelled` status; callers should
        # inspect the status and `last_error`. Polling intervals and the overall timeout
        # are in seconds. Finite timeouts include authentication and request replay
        # time and disable transport retries so the deadline remains strict. Set
        # `timeout` to `nil` to wait indefinitely and retain configured transport retries.
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
          OpenAI::Helpers::ResourcePolling.poll_vector_store_file(
            self,
            file_id,
            vector_store_id: vector_store_id,
            poll_interval: poll_interval,
            timeout: timeout,
            request_options: request_options
          )
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
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] Applied to the upload and attach
        #   requests. Idempotency keys are scoped to each operation.
        #
        # @return [OpenAI::Models::VectorStores::VectorStoreFile]
        def upload(
          vector_store_id,
          file:,
          attributes: nil,
          chunking_strategy: nil,
          request_options: {}
        )
          request_options_scope = OpenAI::Internal::RequestOptionsScope.new(request_options)
          uploaded = @client.files.create(
            file: file,
            purpose: :assistants,
            request_options: request_options_scope.child("file-upload")
          )
          params = {
            file_id: uploaded.id,
            request_options: request_options_scope.child("vector-store-file")
          }
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
        #   and polling requests. Idempotency keys are scoped to each write.
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
      end
    end
  end
end
