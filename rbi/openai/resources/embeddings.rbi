# typed: strong

module OpenAI
  module Resources
    class Embeddings
      # Creates an embedding vector representing the input text.
      sig do
        params(
          input: OpenAI::EmbeddingCreateParams::Input::Variants,
          model: OpenAI::EmbeddingCreateParams::Model::Variants,
          dimensions: Integer,
          encoding_format:
            OpenAI::EmbeddingCreateParams::EncodingFormat::OrSymbol,
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::CreateEmbeddingResponse)
      end
      def create(
        # Input text to embed, encoded as a string or array of tokens. To embed multiple
        # inputs in a single request, pass an array of strings or array of token arrays.
        # The input must not exceed the max input tokens for the model (8192 tokens for
        # all embedding models), cannot be an empty string, and any array must be 2048
        # dimensions or less.
        # [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
        # for counting tokens. In addition to the per-input token limit, all embedding
        # models enforce a maximum of 300,000 tokens summed across all inputs in a single
        # request.
        input:,
        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        model:,
        # The number of dimensions the resulting output embeddings should have. Only
        # supported in `text-embedding-3` and later models.
        dimensions: nil,
        # The format to return the embeddings in. Can be either `float` or
        # [`base64`](https://pypi.org/project/pybase64/).
        encoding_format: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
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
