# typed: strong

module OpenAI
  module Models
    class Embedding < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::Embedding, OpenAI::Internal::AnyHash) }

      # The embedding vector, which is a list of floats. The length of vector depends on
      # the model as listed in the
      # [embedding guide](https://platform.openai.com/docs/guides/embeddings).
      sig { returns(T::Array[Float]) }
      attr_accessor :embedding

      # The index of the embedding in the list of embeddings.
      sig { returns(Integer) }
      attr_accessor :index

      # The object type, which is always "embedding".
      sig { returns(Symbol) }
      attr_accessor :object

      # Represents an embedding vector returned by embedding endpoint.
      sig do
        params(
          embedding: T::Array[Float],
          index: Integer,
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # The embedding vector, which is a list of floats. The length of vector depends on
        # the model as listed in the
        # [embedding guide](https://platform.openai.com/docs/guides/embeddings).
        embedding:,
        # The index of the embedding in the list of embeddings.
        index:,
        # The object type, which is always "embedding".
        object: :embedding
      )
      end

      sig do
        override.returns(
          { embedding: T::Array[Float], index: Integer, object: Symbol }
        )
      end
      def to_hash
      end
    end
  end
end
