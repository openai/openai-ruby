# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#content
      class FileContentParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute vector_store_id
        #
        #   @return [String]
        required :vector_store_id, String

        # @!attribute file_id
        #
        #   @return [String]
        required :file_id, String

        # @!method initialize(vector_store_id:, file_id:, request_options: {})
        #   @param vector_store_id [String]
        #   @param file_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
