# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      class FileDeleteParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
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
