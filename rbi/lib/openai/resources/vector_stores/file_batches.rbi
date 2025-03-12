# typed: strong

module OpenAI
  module Resources
    class VectorStores
      class FileBatches
        sig do
          params(
            vector_store_id: String,
            file_ids: T::Array[String],
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            ),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def create(vector_store_id, file_ids:, attributes: nil, chunking_strategy: nil, request_options: {})
        end

        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def retrieve(batch_id, vector_store_id:, request_options: {})
        end

        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileBatch)
        end
        def cancel(batch_id, vector_store_id:, request_options: {})
        end

        sig do
          params(
            batch_id: String,
            vector_store_id: String,
            after: String,
            before: String,
            filter: Symbol,
            limit: Integer,
            order: Symbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::VectorStores::VectorStoreFile])
        end
        def list_files(
          batch_id,
          vector_store_id:,
          after: nil,
          before: nil,
          filter: nil,
          limit: nil,
          order: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
