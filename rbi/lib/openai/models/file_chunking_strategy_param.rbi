# typed: strong

module OpenAI
  module Models
    # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
    #   strategy. Only applicable if `file_ids` is non-empty.
    class FileChunkingStrategyParam < OpenAI::Union
      abstract!

      class << self
        # @api private
        sig do
          override
            .returns(
              [[Symbol, OpenAI::Models::AutoFileChunkingStrategyParam], [Symbol, OpenAI::Models::StaticFileChunkingStrategyObjectParam]]
            )
        end
        private def variants
        end
      end
    end
  end
end
