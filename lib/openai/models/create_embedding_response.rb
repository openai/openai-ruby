# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Embeddings#create
    class CreateEmbeddingResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute data
      #   The list of embeddings generated by the model.
      #
      #   @return [Array<OpenAI::Models::Embedding>]
      required :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Embedding] }

      # @!attribute model
      #   The name of the model used to generate the embedding.
      #
      #   @return [String]
      required :model, String

      # @!attribute object
      #   The object type, which is always "list".
      #
      #   @return [Symbol, :list]
      required :object, const: :list

      # @!attribute usage
      #   The usage information for the request.
      #
      #   @return [OpenAI::Models::CreateEmbeddingResponse::Usage]
      required :usage, -> { OpenAI::CreateEmbeddingResponse::Usage }

      # @!method initialize(data:, model:, usage:, object: :list)
      #   @param data [Array<OpenAI::Models::Embedding>] The list of embeddings generated by the model.
      #
      #   @param model [String] The name of the model used to generate the embedding.
      #
      #   @param usage [OpenAI::Models::CreateEmbeddingResponse::Usage] The usage information for the request.
      #
      #   @param object [Symbol, :list] The object type, which is always "list".

      # @see OpenAI::Models::CreateEmbeddingResponse#usage
      class Usage < OpenAI::Internal::Type::BaseModel
        # @!attribute prompt_tokens
        #   The number of tokens used by the prompt.
        #
        #   @return [Integer]
        required :prompt_tokens, Integer

        # @!attribute total_tokens
        #   The total number of tokens used by the request.
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!method initialize(prompt_tokens:, total_tokens:)
        #   The usage information for the request.
        #
        #   @param prompt_tokens [Integer] The number of tokens used by the prompt.
        #
        #   @param total_tokens [Integer] The total number of tokens used by the request.
      end
    end
  end
end
