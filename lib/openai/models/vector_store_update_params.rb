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
      #   @return [OpenAI::VectorStoreExpirationAfter, nil]
      optional :expires_after, -> { OpenAI::VectorStoreExpirationAfter }, nil?: true

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
      #   @param expires_after [OpenAI::VectorStoreExpirationAfter, nil] The expiration policy for a vector store.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param name [String, nil] The name of the vector store.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
