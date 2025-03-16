# typed: strong

module OpenAI
  module Models
    class EmbeddingModel < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      TEXT_EMBEDDING_ADA_002 = :"text-embedding-ada-002"
      TEXT_EMBEDDING_3_SMALL = :"text-embedding-3-small"
      TEXT_EMBEDDING_3_LARGE = :"text-embedding-3-large"
    end
  end
end
