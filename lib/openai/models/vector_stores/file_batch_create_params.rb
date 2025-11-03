# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::FileBatches#create
      class FileBatchCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

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
                   OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::FileBatchCreateParams::Attribute]
                 },
                 nil?: true

        # @!attribute chunking_strategy
        #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #   strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
        optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

        # @!attribute file_ids
        #   A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        #   the vector store should use. Useful for tools like `file_search` that can access
        #   files. If `attributes` or `chunking_strategy` are provided, they will be applied
        #   to all files in the batch. Mutually exclusive with `files`.
        #
        #   @return [Array<String>, nil]
        optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute files
        #   A list of objects that each include a `file_id` plus optional `attributes` or
        #   `chunking_strategy`. Use this when you need to override metadata for specific
        #   files. The global `attributes` or `chunking_strategy` will be ignored and must
        #   be specified for each file. Mutually exclusive with `file_ids`.
        #
        #   @return [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>, nil]
        optional :files, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::VectorStores::FileBatchCreateParams::File] }

        # @!method initialize(attributes: nil, chunking_strategy: nil, file_ids: nil, files: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::VectorStores::FileBatchCreateParams} for more details.
        #
        #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #
        #   @param file_ids [Array<String>] A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        #
        #   @param files [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>] A list of objects that each include a `file_id` plus optional `attributes` or `c
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

        class File < OpenAI::Internal::Type::BaseModel
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
                     OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::FileBatchCreateParams::File::Attribute]
                   },
                   nil?: true

          # @!attribute chunking_strategy
          #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #   strategy. Only applicable if `file_ids` is non-empty.
          #
          #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
          optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

          # @!method initialize(file_id:, attributes: nil, chunking_strategy: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::VectorStores::FileBatchCreateParams::File} for more details.
          #
          #   @param file_id [String] A [File](https://platform.openai.com/docs/api-reference/files) ID that the vecto
          #
          #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`

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
end
