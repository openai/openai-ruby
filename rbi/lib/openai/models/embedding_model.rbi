# typed: strong

module OpenAI
  module Models
    module EmbeddingModel
      extend OpenAI::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::EmbeddingModel) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::EmbeddingModel::TaggedSymbol) }

      TEXT_EMBEDDING_ADA_002 = T.let(:"text-embedding-ada-002", OpenAI::Models::EmbeddingModel::OrSymbol)
      TEXT_EMBEDDING_3_SMALL = T.let(:"text-embedding-3-small", OpenAI::Models::EmbeddingModel::OrSymbol)
      TEXT_EMBEDDING_3_LARGE = T.let(:"text-embedding-3-large", OpenAI::Models::EmbeddingModel::OrSymbol)
    end
  end
end
