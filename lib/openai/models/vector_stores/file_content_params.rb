# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#content
      class FileContentParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute vector_store_id
        #
        #   @return [String]
        required :vector_store_id, String

        # @!parse
        #   # @param vector_store_id [String]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(vector_store_id:, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
