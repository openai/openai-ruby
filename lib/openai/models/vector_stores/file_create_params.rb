# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#create
      class FileCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute file_id
        #   A [File](https://platform.openai.com/docs/api-reference/files) ID that the
        #   vector store should use. Useful for tools like `file_search` that can access
        #   files.
        #
        #   @return [String]
        required :file_id, String

        # @!attribute attributes
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        #
        #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
        optional :attributes,
                 -> {
                   OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::FileCreateParams::Attribute]
                 },
                 nil?: true

        # @!attribute chunking_strategy
        #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #   strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
        optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

        # @!method initialize(file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::VectorStores::FileCreateParams} for more details.
        #
        #   @param file_id [String] A [File](https://platform.openai.com/docs/api-reference/files) ID that the vecto
        #
        #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        module Attribute
          extend OpenAI::Internal::Type::Union

          variant String

          variant Float

          variant OpenAI::Internal::Type::Boolean

          # @!method self.variants
          #   @return [Array(String, Float, Boolean)]
        end
      end
    end
  end
end
