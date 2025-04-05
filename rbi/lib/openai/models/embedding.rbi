# typed: strong

module OpenAI
  module Models
    class Embedding < OpenAI::Internal::Type::BaseModel
      # The embedding vector, which is a list of floats. The length of vector depends on
      #   the model as listed in the
      #   [embedding guide](https://platform.openai.com/docs/guides/embeddings).
      sig { returns(T::Array[Float]) }
      attr_accessor :embedding

      # The index of the embedding in the list of embeddings.
      sig { returns(Integer) }
      attr_accessor :index

      # The object type, which is always "embedding".
      sig { returns(Symbol) }
      attr_accessor :object

      # Represents an embedding vector returned by embedding endpoint.
      sig { params(embedding: T::Array[Float], index: Integer, object: Symbol).returns(T.attached_class) }
      def self.new(embedding:, index:, object: :embedding); end

      sig { override.returns({embedding: T::Array[Float], index: Integer, object: Symbol}) }
      def to_hash; end
    end
  end
end
