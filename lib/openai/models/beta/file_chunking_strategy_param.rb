# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      #
      # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #   strategy. Only applicable if `file_ids` is non-empty.
      class FileChunkingStrategyParam < OpenAI::Union
        discriminator :type

        # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
        variant :auto, -> { OpenAI::Models::Beta::AutoFileChunkingStrategyParam }

        variant :static, -> { OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam)]
        #     def variants; end
        #   end
      end
    end
  end
end
