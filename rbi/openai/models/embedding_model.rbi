# typed: strong

module OpenAI
  module Models
    module EmbeddingModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::EmbeddingModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      TEXT_EMBEDDING_ADA_002 = T.let(:"text-embedding-ada-002", OpenAI::Models::EmbeddingModel::TaggedSymbol)
      TEXT_EMBEDDING_3_SMALL = T.let(:"text-embedding-3-small", OpenAI::Models::EmbeddingModel::TaggedSymbol)
      TEXT_EMBEDDING_3_LARGE = T.let(:"text-embedding-3-large", OpenAI::Models::EmbeddingModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::Models::EmbeddingModel::TaggedSymbol]) }
      def self.values; end
    end
  end
end
