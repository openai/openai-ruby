# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#create
    class VectorStoreCreateParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute [r] chunking_strategy
      #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #   strategy. Only applicable if `file_ids` is non-empty.
      #
      #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
      optional :chunking_strategy, union: -> { OpenAI::Models::FileChunkingStrategyParam }

      # @!parse
      #   # @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
      #   attr_writer :chunking_strategy

      # @!attribute [r] expires_after
      #   The expiration policy for a vector store.
      #
      #   @return [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::Models::VectorStoreCreateParams::ExpiresAfter }

      # @!parse
      #   # @return [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter]
      #   attr_writer :expires_after

      # @!attribute [r] file_ids
      #   A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      #   the vector store should use. Useful for tools like `file_search` that can access
      #   files.
      #
      #   @return [Array<String>, nil]
      optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

      # @!parse
      #   # @return [Array<String>]
      #   attr_writer :file_ids

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!attribute [r] name
      #   The name of the vector store.
      #
      #   @return [String, nil]
      optional :name, String

      # @!parse
      #   # @return [String]
      #   attr_writer :name

      # @!method initialize(chunking_strategy: nil, expires_after: nil, file_ids: nil, metadata: nil, name: nil, request_options: {})
      #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam]
      #   @param expires_after [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter]
      #   @param file_ids [Array<String>]
      #   @param metadata [Hash{Symbol=>String}, nil]
      #   @param name [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `last_active_at`.
        #
        #   @return [Symbol, :last_active_at]
        required :anchor, const: :last_active_at

        # @!attribute days
        #   The number of days after the anchor time that the vector store will expire.
        #
        #   @return [Integer]
        required :days, Integer

        # @!method initialize(days:, anchor: :last_active_at)
        #   The expiration policy for a vector store.
        #
        #   @param days [Integer]
        #   @param anchor [Symbol, :last_active_at]
      end
    end
  end
end
