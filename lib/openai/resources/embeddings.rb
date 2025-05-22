# frozen_string_literal: true

module OpenAI
  module Resources
    class Embeddings
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::EmbeddingCreateParams} for more details.
      #
      # Creates an embedding vector representing the input text.
      #
      # @overload create(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<Integer>, Array<Array<Integer>>] Input text to embed, encoded as a string or array of tokens. To embed multiple i
      #
      # @param model [String, Symbol, OpenAI::Models::EmbeddingModel] ID of the model to use. You can use the [List models](https://platform.openai.co
      #
      # @param dimensions [Integer] The number of dimensions the resulting output embeddings should have. Only suppo
      #
      # @param encoding_format [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat] The format to return the embeddings in. Can be either `float` or [`base64`](http
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
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
