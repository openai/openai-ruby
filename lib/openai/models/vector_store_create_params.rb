# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#create
    class VectorStoreCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute chunking_strategy
      #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #   strategy. Only applicable if `file_ids` is non-empty.
      #
      #   @return [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam, nil]
      optional :chunking_strategy, union: -> { OpenAI::FileChunkingStrategyParam }

      # @!attribute description
      #   A description for the vector store. Can be used to describe the vector store's
      #   purpose.
      #
      #   @return [String, nil]
      optional :description, String

      # @!attribute expires_after
      #   The expiration policy for a vector store.
      #
      #   @return [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::VectorStoreCreateParams::ExpiresAfter }

      # @!attribute file_ids
      #   A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      #   the vector store should use. Useful for tools like `file_search` that can access
      #   files.
      #
      #   @return [Array<String>, nil]
      optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

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

      # @!attribute name
      #   The name of the vector store.
      #
      #   @return [String, nil]
      optional :name, String

      # @!method initialize(chunking_strategy: nil, description: nil, expires_after: nil, file_ids: nil, metadata: nil, name: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VectorStoreCreateParams} for more details.
      #
      #   @param chunking_strategy [OpenAI::Models::AutoFileChunkingStrategyParam, OpenAI::Models::StaticFileChunkingStrategyObjectParam] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #
      #   @param description [String] A description for the vector store. Can be used to describe the vector store's p
      #
      #   @param expires_after [OpenAI::Models::VectorStoreCreateParams::ExpiresAfter] The expiration policy for a vector store.
      #
      #   @param file_ids [Array<String>] A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param name [String] The name of the vector store.
      #
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
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::VectorStoreCreateParams::ExpiresAfter} for more details.
        #
        #   The expiration policy for a vector store.
        #
        #   @param days [Integer] The number of days after the anchor time that the vector store will expire.
        #
        #   @param anchor [Symbol, :last_active_at] Anchor timestamp after which the expiration policy applies. Supported anchors: `
      end
    end
  end
end
