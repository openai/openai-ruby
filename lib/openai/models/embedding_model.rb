# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    class EmbeddingModel < OpenAI::Enum
      TEXT_EMBEDDING_ADA_002 = :"text-embedding-ada-002"
      TEXT_EMBEDDING_3_SMALL = :"text-embedding-3-small"
      TEXT_EMBEDDING_3_LARGE = :"text-embedding-3-large"

      finalize!
    end
  end
end
