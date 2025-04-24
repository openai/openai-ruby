# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#update
    class VectorStoreUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute expires_after
      #   The expiration policy for a vector store.
      #
      #   @return [OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter }, nil?: true

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
      optional :name, String, nil?: true

      # @!method initialize(expires_after: nil, metadata: nil, name: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VectorStoreUpdateParams} for more details.
      #
      #   @param expires_after [OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, nil] The expiration policy for a vector store.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      #   @param name [String, nil] The name of the vector store.
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
        #   {OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter} for more details.
        #
        #   The expiration policy for a vector store.
        #
        #   @param days [Integer] The number of days after the anchor time that the vector store will expire.
        #
        #   @param anchor [Symbol, :last_active_at] Anchor timestamp after which the expiration policy applies. Supported anchors: `
        #   ...
      end
    end
  end
end
