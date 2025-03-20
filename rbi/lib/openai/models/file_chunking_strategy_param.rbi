# typed: strong

module OpenAI
  module Models
    # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
    #   strategy. Only applicable if `file_ids` is non-empty.
    module FileChunkingStrategyParam
      extend OpenAI::Union

      Variants =
        type_template(:out) do
          {
            fixed: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            )
          }
        end
    end
  end
end
