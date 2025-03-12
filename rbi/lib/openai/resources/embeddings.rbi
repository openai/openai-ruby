# typed: strong

module OpenAI
  module Resources
    class Embeddings
      sig do
        params(
          input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
          model: T.any(String, Symbol),
          dimensions: Integer,
          encoding_format: Symbol,
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::CreateEmbeddingResponse)
      end
      def create(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
