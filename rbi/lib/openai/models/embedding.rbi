# typed: strong

module OpenAI
  module Models
    class Embedding < OpenAI::BaseModel
      # The embedding vector, which is a list of floats. The length of vector depends on
      #   the model as listed in the
      #   [embedding guide](https://platform.openai.com/docs/guides/embeddings).
      sig { returns(T::Array[Float]) }
      def embedding
      end

      sig { params(_: T::Array[Float]).returns(T::Array[Float]) }
      def embedding=(_)
      end

      # The index of the embedding in the list of embeddings.
      sig { returns(Integer) }
      def index
      end

      sig { params(_: Integer).returns(Integer) }
      def index=(_)
      end

      # The object type, which is always "embedding".
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # Represents an embedding vector returned by embedding endpoint.
      sig { params(embedding: T::Array[Float], index: Integer, object: Symbol).returns(T.attached_class) }
      def self.new(embedding:, index:, object: :embedding)
      end

      sig { override.returns({embedding: T::Array[Float], index: Integer, object: Symbol}) }
      def to_hash
      end
    end
  end
end
