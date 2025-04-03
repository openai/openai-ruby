# frozen_string_literal: true

module OpenAI
  module Models
    module EmbeddingModel
      extend OpenAI::Internal::Type::Enum

      TEXT_EMBEDDING_ADA_002 = :"text-embedding-ada-002"
      TEXT_EMBEDDING_3_SMALL = :"text-embedding-3-small"
      TEXT_EMBEDDING_3_LARGE = :"text-embedding-3-large"

      finalize!

      # @!parse
      #   # @return [Array<Symbol>]
      #   def self.values; end
    end
  end
end
