# typed: strong

module OpenAI
  module Resources
    class VectorStores
      sig { returns(OpenAI::Resources::VectorStores::Files) }
      def files
      end

      sig { returns(OpenAI::Resources::VectorStores::FileBatches) }
      def file_batches
      end

      sig do
        params(
          chunking_strategy: T.any(
            OpenAI::Models::AutoFileChunkingStrategyParam,
            OpenAI::Models::StaticFileChunkingStrategyObjectParam
          ),
          expires_after: OpenAI::Models::VectorStoreCreateParams::ExpiresAfter,
          file_ids: T::Array[String],
          metadata: T.nilable(OpenAI::Models::Metadata),
          name: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::VectorStore)
      end
      def create(
        chunking_strategy: nil,
        expires_after: nil,
        file_ids: nil,
        metadata: nil,
        name: nil,
        request_options: {}
      )
      end

      sig do
        params(
          vector_store_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::VectorStore)
      end
      def retrieve(vector_store_id, request_options: {})
      end

      sig do
        params(
          vector_store_id: String,
          expires_after: T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter),
          metadata: T.nilable(OpenAI::Models::Metadata),
          name: T.nilable(String),
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::VectorStore)
      end
      def update(vector_store_id, expires_after: nil, metadata: nil, name: nil, request_options: {})
      end

      sig do
        params(
          after: String,
          before: String,
          limit: Integer,
          order: Symbol,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::CursorPage[OpenAI::Models::VectorStore])
      end
      def list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
      end

      sig do
        params(
          vector_store_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::VectorStoreDeleted)
      end
      def delete(vector_store_id, request_options: {})
      end

      sig do
        params(
          vector_store_id: String,
          query: T.any(String, T::Array[String]),
          filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter),
          max_num_results: Integer,
          ranking_options: OpenAI::Models::VectorStoreSearchParams::RankingOptions,
          rewrite_query: T::Boolean,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Page[OpenAI::Models::VectorStoreSearchResponse])
      end
      def search(
        vector_store_id,
        query:,
        filters: nil,
        max_num_results: nil,
        ranking_options: nil,
        rewrite_query: nil,
        request_options: {}
      )
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
