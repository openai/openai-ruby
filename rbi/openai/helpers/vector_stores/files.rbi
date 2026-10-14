# typed: strong

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Attach a file to a vector store and wait for processing to finish.
        sig do
          params(
            vector_store_id: String,
            file_id: String,
            attributes: T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileCreateParams::Attribute::Variants
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
            .returns(OpenAI::VectorStores::VectorStoreFile)
        end
        def create_and_poll(
          vector_store_id,
          file_id:,
          attributes: nil,
          chunking_strategy: nil,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
        end

        # Wait for a vector store file to finish processing.
        sig do
          params(
            file_id: String,
            vector_store_id: String,
            poll_interval: T.nilable(T.any(Integer, Float)),
            timeout: T.nilable(T.any(Integer, Float)),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::VectorStores::VectorStoreFile)
        end
        def poll(
          file_id,
          vector_store_id:,
          poll_interval: nil,
          timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
          request_options: {}
        )
        end

        # Upload a file and attach it to a vector store.
        sig do
          params(
            vector_store_id: String,
            file: OpenAI::Internal::FileInput,
            attributes: T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileCreateParams::Attribute::Variants
              ]
            ),
            chunking_strategy: T.any(
              OpenAI::AutoFileChunkingStrategyParam::OrHash,
              OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
            ),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::VectorStores::VectorStoreFile)
        end
        def upload(
          vector_store_id,
          file:,
          attributes: nil,
          chunking_strategy: nil,
          request_options: {}
        )
        end

        # Upload a file, attach it to a vector store, and wait for processing to
        # finish.
        sig do
          params(
            vector_store_id: String,
            file: OpenAI::Internal::FileInput,
            attributes: T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileCreateParams::Attribute::Variants
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
            .returns(OpenAI::VectorStores::VectorStoreFile)
        end
        def upload_and_poll(
          vector_store_id,
          file:,
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
