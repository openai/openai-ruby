# frozen_string_literal: true

module OpenAI
  module Resources
    # Get a vector representation of a given input that can be easily consumed by
    # machine learning models and algorithms.
    class Embeddings
      # Creates an embedding vector representing the input text.
      #
      # @overload create(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<Integer>, Array<Array<Integer>>]
      #   Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   all embedding models), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. In addition to the per-input token limit, all embedding
      #   models enforce a maximum of 300,000 tokens summed across all inputs in a single
      #   request.
      #
      # @param model [String, Symbol, OpenAI::Models::EmbeddingModel]
      #   ID of the model to use. You can use the
      #   [List models](https://developers.openai.com/api/reference/resources/models/methods/list)
      #   API to see all of your available models, or see our
      #   [Model overview](https://developers.openai.com/api/docs/models) for descriptions
      #   of them.
      #
      # @param dimensions [Integer]
      #   The number of dimensions the resulting output embeddings should have. Only
      #   supported in `text-embedding-3` and later models.
      #
      # @param encoding_format [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat]
      #   The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::CreateEmbeddingResponse]
      #
      # @see OpenAI::Models::EmbeddingCreateParams
      def create(params)
        parsed, options = OpenAI::EmbeddingCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "embeddings",
          body: parsed,
          model: OpenAI::CreateEmbeddingResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
