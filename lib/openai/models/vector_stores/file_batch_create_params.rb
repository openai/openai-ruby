# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::FileBatches#create
      class FileBatchCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute vector_store_id
        #
        #   @return [String]
        required :vector_store_id, String

        # @!attribute attributes
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        #
        #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
        optional(
          :attributes,
          -> {
            OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::FileBatchCreateParams::Attribute]
          },
          nil?: true
        )

        # @!attribute chunking_strategy
        #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #   strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
        optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

        # @!attribute file_ids
        #   A list of [File](https://developers.openai.com/api/reference/resources/files)
        #   IDs that the vector store should use. Useful for tools like `file_search` that
        #   can access files. If `attributes` or `chunking_strategy` are provided, they will
        #   be applied to all files in the batch. The maximum batch size is 2000 files. This
        #   endpoint is recommended for multi-file ingestion and helps reduce
        #   per-vector-store write request pressure. Mutually exclusive with `files`.
        #
        #   @return [Array<String>, nil]
        optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute files
        #   A list of objects that each include a `file_id` plus optional `attributes` or
        #   `chunking_strategy`. Use this when you need to override metadata for specific
        #   files. The global `attributes` or `chunking_strategy` will be ignored and must
        #   be specified for each file. The maximum batch size is 2000 files. This endpoint
        #   is recommended for multi-file ingestion and helps reduce per-vector-store write
        #   request pressure. Mutually exclusive with `file_ids`.
        #
        #   @return [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>, nil]
        optional :files, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::VectorStores::FileBatchCreateParams::File] }

        # @!method initialize(vector_store_id:, attributes: nil, chunking_strategy: nil, file_ids: nil, files: nil, request_options: {})
        #   @param vector_store_id [String]
        #
        #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        #     Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard. Keys are strings with a maximum
        #     length of 64 characters. Values are strings with a maximum length of 512
        #     characters, booleans, or numbers.
        #
        #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
        #     The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        #     strategy. Only applicable if `file_ids` is non-empty.
        #
        #   @param file_ids [Array<String>]
        #     A list of [File](https://developers.openai.com/api/reference/resources/files)
        #     IDs that the vector store should use. Useful for tools like `file_search` that
        #     can access files. If `attributes` or `chunking_strategy` are provided, they will
        #     be applied to all files in the batch. The maximum batch size is 2000 files. This
        #     endpoint is recommended for multi-file ingestion and helps reduce
        #     per-vector-store write request pressure. Mutually exclusive with `files`.
        #
        #   @param files [Array<OpenAI::Models::VectorStores::FileBatchCreateParams::File>]
        #     A list of objects that each include a `file_id` plus optional `attributes` or
        #     `chunking_strategy`. Use this when you need to override metadata for specific
        #     files. The global `attributes` or `chunking_strategy` will be ignored and must
        #     be specified for each file. The maximum batch size is 2000 files. This endpoint
        #     is recommended for multi-file ingestion and helps reduce per-vector-store write
        #     request pressure. Mutually exclusive with `file_ids`.
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
          #   A [File](https://developers.openai.com/api/reference/resources/files) ID that
          #   the vector store should use. Useful for tools like `file_search` that can access
          #   files. For multi-file ingestion, we recommend
          #   [`file_batches`](https://developers.openai.com/api/reference/resources/vector_stores/subresources/file_batches/methods/create)
          #   to minimize per-vector-store write requests.
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
          optional(
            :attributes,
            -> {
              OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::FileBatchCreateParams::File::Attribute]
            },
            nil?: true
          )

          # @!attribute chunking_strategy
          #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #   strategy. Only applicable if `file_ids` is non-empty.
          #
          #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
          optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

          # @!method initialize(file_id:, attributes: nil, chunking_strategy: nil)
          #   @param file_id [String]
          #     A [File](https://developers.openai.com/api/reference/resources/files) ID that
          #     the vector store should use. Useful for tools like `file_search` that can access
          #     files. For multi-file ingestion, we recommend
          #     [`file_batches`](https://developers.openai.com/api/reference/resources/vector_stores/subresources/file_batches/methods/create)
          #     to minimize per-vector-store write requests.
          #
          #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
          #     Set of 16 key-value pairs that can be attached to an object. This can be useful
          #     for storing additional information about the object in a structured format, and
          #     querying for objects via API or the dashboard. Keys are strings with a maximum
          #     length of 64 characters. Values are strings with a maximum length of 512
          #     characters, booleans, or numbers.
          #
          #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
          #     The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #     strategy. Only applicable if `file_ids` is non-empty.
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
