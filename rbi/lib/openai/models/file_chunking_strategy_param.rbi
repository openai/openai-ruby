# typed: strong

module OpenAI
  module Models
    # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
    #   strategy. Only applicable if `file_ids` is non-empty.
    class FileChunkingStrategyParam < OpenAI::Union
      abstract!

      class << self
        sig do
          override
            .returns(
              [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
            )
        end
        def variants
        end
      end
    end
  end
end
