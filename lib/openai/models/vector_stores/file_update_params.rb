# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#update
      class FileUpdateParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
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
        required :attributes,
                 -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStores::FileUpdateParams::Attribute] },
                 nil?: true

        # @!method initialize(vector_store_id:, attributes:, request_options: {})
        #   @param vector_store_id [String]
        #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
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
