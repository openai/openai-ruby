# frozen_string_literal: true

module OpenAI
  module Models
    class Embedding < OpenAI::Internal::Type::BaseModel
      # @!attribute embedding
      #   The embedding vector, which is a list of floats. The length of vector depends on
      #   the model as listed in the
      #   [embedding guide](https://platform.openai.com/docs/guides/embeddings).
      #
      #   @return [Array<Float>]
      required :embedding, OpenAI::Internal::Type::ArrayOf[Float]

      # @!attribute index
      #   The index of the embedding in the list of embeddings.
      #
      #   @return [Integer]
      required :index, Integer

      # @!attribute object
      #   The object type, which is always "embedding".
      #
      #   @return [Symbol, :embedding]
      required :object, const: :embedding

      # @!parse
      #   # Represents an embedding vector returned by embedding endpoint.
      #   #
      #   # @param embedding [Array<Float>]
      #   # @param index [Integer]
      #   # @param object [Symbol, :embedding]
      #   #
      #   def initialize(embedding:, index:, object: :embedding, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
