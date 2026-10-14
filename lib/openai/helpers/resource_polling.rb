# frozen_string_literal: true

module OpenAI
  module Helpers
    # Product-specific status handling for file and vector-store polling.
    #
    # @api private
    module ResourcePolling
      # @api private
      #
      # @return [OpenAI::Models::FileObject]
      def self.wait_for_file(resource, file_id, poll_interval:, timeout:, request_options:)
        poller = OpenAI::Internal::Poller.new(
          operation: "file #{file_id}",
          poll_interval: poll_interval,
          timeout: timeout
        )
        file = nil

        begin
          loop do
            file = poller.request(request_options, resource: file) do |options|
              resource.retrieve(file_id, request_options: options)
            end

            case file.status
            when OpenAI::FileObject::Status::UPLOADED
              poller.wait(file)
            when
                OpenAI::FileObject::Status::PROCESSED,
                OpenAI::FileObject::Status::ERROR,
                :deleted,
                "deleted"
              return file
            else
              raise(
                OpenAI::Errors::PollingError,
                "Unexpected status while waiting for file #{file_id}: #{file.status.inspect}"
              )
            end
          end

        rescue OpenAI::Errors::APITimeoutError
          poller.check_deadline!(file)
          raise
        end
      end

      # @api private
      #
      # @return [OpenAI::Models::VectorStores::VectorStoreFile]
      def self.poll_vector_store_file(
        resource,
        file_id,
        vector_store_id:,
        poll_interval:,
        timeout:,
        request_options:
      )
        poller = OpenAI::Internal::Poller.new(
          operation: "vector store file #{file_id}",
          poll_interval: poll_interval,
          timeout: timeout
        )
        file = nil

        begin
          loop do
            file = poller
              .request(
                request_options,
                extra_headers: {"OpenAI-Beta" => "assistants=v2"},
                resource: file
              ) do |options|
                resource.retrieve(file_id, vector_store_id: vector_store_id, request_options: options)
              end

            case file.status
            when OpenAI::VectorStores::VectorStoreFile::Status::IN_PROGRESS
              poller.wait(file)
            when
                OpenAI::VectorStores::VectorStoreFile::Status::COMPLETED,
                OpenAI::VectorStores::VectorStoreFile::Status::FAILED,
                OpenAI::VectorStores::VectorStoreFile::Status::CANCELLED
              return file
            else
              raise(
                OpenAI::Errors::PollingError,
                "Unexpected status while waiting for vector store file " \
                  "#{file_id}: #{file.status.inspect}"
              )
            end
          end

        rescue OpenAI::Errors::APITimeoutError
          poller.check_deadline!(file)
          raise
        end
      end

      # @api private
      #
      # @return [OpenAI::Models::VectorStores::VectorStoreFileBatch]
      def self.poll_vector_store_file_batch(
        resource,
        batch_id,
        vector_store_id:,
        poll_interval:,
        timeout:,
        request_options:
      )
        poller = OpenAI::Internal::Poller.new(
          operation: "vector store file batch #{batch_id}",
          poll_interval: poll_interval,
          timeout: timeout
        )
        batch = nil

        begin
          loop do
            batch = poller
              .request(
                request_options,
                extra_headers: {"OpenAI-Beta" => "assistants=v2"},
                resource: batch
              ) do |options|
                resource.retrieve(batch_id, vector_store_id: vector_store_id, request_options: options)
              end

            case batch.status
            when OpenAI::VectorStores::VectorStoreFileBatch::Status::IN_PROGRESS
              poller.wait(batch)
            when
                OpenAI::VectorStores::VectorStoreFileBatch::Status::COMPLETED,
                OpenAI::VectorStores::VectorStoreFileBatch::Status::FAILED,
                OpenAI::VectorStores::VectorStoreFileBatch::Status::CANCELLED
              return batch
            else
              raise(
                OpenAI::Errors::PollingError,
                "Unexpected status while waiting for vector store file batch " \
                  "#{batch_id}: #{batch.status.inspect}"
              )
            end
          end

        rescue OpenAI::Errors::APITimeoutError
          poller.check_deadline!(batch)
          raise
        end
      end
    end
  end
end
