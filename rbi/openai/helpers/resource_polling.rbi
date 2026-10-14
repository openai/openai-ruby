# typed: strong

module OpenAI
  module Helpers
    # @api private
    module ResourcePolling
      sig do
        params(
          resource: OpenAI::Resources::Files,
          file_id: String,
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float)),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        )
          .returns(OpenAI::Models::FileObject)
      end
      def self.wait_for_file(resource, file_id, poll_interval:, timeout:, request_options:)
      end

      sig do
        params(
          resource: OpenAI::Resources::VectorStores::Files,
          file_id: String,
          vector_store_id: String,
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float)),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        )
          .returns(OpenAI::Models::VectorStores::VectorStoreFile)
      end
      def self.poll_vector_store_file(
        resource,
        file_id,
        vector_store_id:,
        poll_interval:,
        timeout:,
        request_options:
      )
      end

      sig do
        params(
          resource: OpenAI::Resources::VectorStores::FileBatches,
          batch_id: String,
          vector_store_id: String,
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float)),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        )
          .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
      end
      def self.poll_vector_store_file_batch(
        resource,
        batch_id,
        vector_store_id:,
        poll_interval:,
        timeout:,
        request_options:
      )
      end
    end
  end
end
