# typed: strong

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        # Create a vector store file batch and wait for processing to finish.
        sig do
          params(
            vector_store_id: String,
            attributes: T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
              ]
            ),
            chunking_strategy: T.any(
              OpenAI::AutoFileChunkingStrategyParam::OrHash,
              OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
            ),
            file_ids: T::Array[String],
            files: T::Array[
              OpenAI::VectorStores::FileBatchCreateParams::File::OrHash
            ],
            poll_interval: T.nilable(T.any(Integer, Float)),
            timeout: T.nilable(T.any(Integer, Float)),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::VectorStores::VectorStoreFileBatch)
        end
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
        end

        # Wait for a vector store file batch to finish processing.
        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            poll_interval: T.nilable(T.any(Integer, Float)),
            timeout: T.nilable(T.any(Integer, Float)),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::VectorStores::VectorStoreFileBatch)
        end
        def poll(
          batch_id,
          vector_store_id:,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
        end

        # Upload files concurrently, create a vector store file batch, and wait for
        # processing to finish.
        sig do
          params(
            vector_store_id: String,
            files: T::Enumerable[OpenAI::Internal::FileInput],
            file_ids: T::Array[String],
            max_concurrency: Integer,
            attributes: T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
              ]
            ),
            chunking_strategy: T.any(
              OpenAI::AutoFileChunkingStrategyParam::OrHash,
              OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
            ),
            poll_interval: T.nilable(T.any(Integer, Float)),
            timeout: T.nilable(T.any(Integer, Float)),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::VectorStores::VectorStoreFileBatch)
        end
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
        end
      end
    end
  end
end
