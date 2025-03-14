# typed: strong

module OpenAI
  module Resources
    class VectorStores
      class Files
        # Create a vector store file by attaching a
        #   [File](https://platform.openai.com/docs/api-reference/files) to a
        #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object).
        sig do
          params(
            vector_store_id: String,
            file_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            ),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFile)
        end
        def create(vector_store_id, file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        end

        # Retrieves a vector store file.
        sig do
          params(
            file_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFile)
        end
        def retrieve(file_id, vector_store_id:, request_options: {})
        end

        # Update attributes on a vector store file.
        sig do
          params(
            file_id: String,
            vector_store_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFile)
        end
        def update(file_id, vector_store_id:, attributes:, request_options: {})
        end

        # Returns a list of vector store files.
        sig do
          params(
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
        def list(
          vector_store_id,
          after: nil,
          before: nil,
          filter: nil,
          limit: nil,
          order: nil,
          request_options: {}
        )
        end

        # Delete a vector store file. This will remove the file from the vector store but
        #   the file itself will not be deleted. To delete the file, use the
        #   [delete file](https://platform.openai.com/docs/api-reference/files/delete)
        #   endpoint.
        sig do
          params(
            file_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::VectorStores::VectorStoreFileDeleted)
        end
        def delete(file_id, vector_store_id:, request_options: {})
        end

        # Retrieve the parsed contents of a vector store file.
        sig do
          params(
            file_id: String,
            vector_store_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Page[OpenAI::Models::VectorStores::FileContentResponse])
        end
        def content(file_id, vector_store_id:, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
