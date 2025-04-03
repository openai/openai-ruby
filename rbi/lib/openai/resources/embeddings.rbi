# typed: strong

module OpenAI
  module Resources
    class Embeddings
      # Creates an embedding vector representing the input text.
      sig do
        params(
          input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
          model: T.any(String, OpenAI::Models::EmbeddingModel::OrSymbol),
          dimensions: Integer,
          encoding_format: OpenAI::Models::EmbeddingCreateParams::EncodingFormat::OrSymbol,
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
        )
          .returns(OpenAI::Models::CreateEmbeddingResponse)
      end
      def create(
        # Input text to embed, encoded as a string or array of tokens. To embed multiple
        #   inputs in a single request, pass an array of strings or array of token arrays.
        #   The input must not exceed the max input tokens for the model (8192 tokens for
        #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
        #   dimensions or less.
        #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
        #   for counting tokens. Some models may also impose a limit on total number of
        #   tokens summed across inputs.
        input:,
        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        model:,
        # The number of dimensions the resulting output embeddings should have. Only
        #   supported in `text-embedding-3` and later models.
        dimensions: nil,
        # The format to return the embeddings in. Can be either `float` or
        #   [`base64`](https://pypi.org/project/pybase64/).
        encoding_format: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
