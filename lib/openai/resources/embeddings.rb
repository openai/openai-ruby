# frozen_string_literal: true

module OpenAI
  module Resources
    class Embeddings
      # Creates an embedding vector representing the input text.
      #
      # @overload create(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<Integer>, Array<Array<Integer>>]
      # @param model [String, Symbol, OpenAI::Models::EmbeddingModel]
      # @param dimensions [Integer]
      # @param encoding_format [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
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
