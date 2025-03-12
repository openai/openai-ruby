# typed: strong

module OpenAI
  module Models
    class EmbeddingModel < OpenAI::Enum
      abstract!

      TEXT_EMBEDDING_ADA_002 = :"text-embedding-ada-002"
      TEXT_EMBEDDING_3_SMALL = :"text-embedding-3-small"
      TEXT_EMBEDDING_3_LARGE = :"text-embedding-3-large"

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
