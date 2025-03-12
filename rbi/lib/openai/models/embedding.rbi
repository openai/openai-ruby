# typed: strong

module OpenAI
  module Models
    class Embedding < OpenAI::BaseModel
      sig { returns(T::Array[Float]) }
      def embedding
      end

      sig { params(_: T::Array[Float]).returns(T::Array[Float]) }
      def embedding=(_)
      end

      sig { returns(Integer) }
      def index
      end

      sig { params(_: Integer).returns(Integer) }
      def index=(_)
      end

      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      sig { params(embedding: T::Array[Float], index: Integer, object: Symbol).returns(T.attached_class) }
      def self.new(embedding:, index:, object: :embedding)
      end

      sig { override.returns({embedding: T::Array[Float], index: Integer, object: Symbol}) }
      def to_hash
      end
    end
  end
end
