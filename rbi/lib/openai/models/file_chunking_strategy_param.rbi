# typed: strong

module OpenAI
  module Models
    # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
    #   strategy. Only applicable if `file_ids` is non-empty.
    module FileChunkingStrategyParam
      extend OpenAI::Union

      sig do
        override
          .returns(
            [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
          )
      end
      def self.variants
      end
    end
  end
end
