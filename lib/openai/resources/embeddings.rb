# frozen_string_literal: true

module OpenAI
  module Resources
    class Embeddings
      # Creates an embedding vector representing the input text.
      #
      # @param params [OpenAI::Models::EmbeddingCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String, Array<String>, Array<Integer>, Array<Array<Integer>>] :input Input text to embed, encoded as a string or array of tokens. To embed multiple
      #     inputs in a single request, pass an array of strings or array of token arrays.
      #     The input must not exceed the max input tokens for the model (8192 tokens for
      #     `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #     dimensions or less.
      #     [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #     for counting tokens. Some models may also impose a limit on total number of
      #     tokens summed across inputs.
      #
      #   @option params [String, Symbol, OpenAI::Models::EmbeddingModel] :model ID of the model to use. You can use the
      #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #     see all of your available models, or see our
      #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #     them.
      #
      #   @option params [Integer] :dimensions The number of dimensions the resulting output embeddings should have. Only
      #     supported in `text-embedding-3` and later models.
      #
      #   @option params [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat] :encoding_format The format to return the embeddings in. Can be either `float` or
      #     [`base64`](https://pypi.org/project/pybase64/).
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::CreateEmbeddingResponse]
      #
      # @see OpenAI::Models::EmbeddingCreateParams
      def create(params)
        parsed, options = OpenAI::Models::EmbeddingCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "embeddings",
          body: parsed,
          model: OpenAI::Models::CreateEmbeddingResponse,
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
