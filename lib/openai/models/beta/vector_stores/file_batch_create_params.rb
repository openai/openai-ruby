# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module VectorStores
        class FileBatchCreateParams < OpenAI::BaseModel
          # @!parse
          #   extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # @!attribute file_ids
          #   A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
          #     the vector store should use. Useful for tools like `file_search` that can access
          #     files.
          #
          #   @return [Array<String>]
          required :file_ids, OpenAI::ArrayOf[String]

          # @!attribute [r] chunking_strategy
          #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #     strategy. Only applicable if `file_ids` is non-empty.
          #
          #   @return [OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam, nil]
          optional :chunking_strategy, union: -> { OpenAI::Models::Beta::FileChunkingStrategyParam }

          # @!parse
          #   # @return [OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam]
          #   attr_writer :chunking_strategy

          # @!parse
          #   # @param file_ids [Array<String>]
          #   # @param chunking_strategy [OpenAI::Models::Beta::AutoFileChunkingStrategyParam, OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(file_ids:, chunking_strategy: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
