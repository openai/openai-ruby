# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      class FileUpdateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute vector_store_id
        #
        #   @return [String]
        required :vector_store_id, String

        # @!attribute attributes
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard. Keys are strings with a maximum
        #     length of 64 characters. Values are strings with a maximum length of 512
        #     characters, booleans, or numbers.
        #
        #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
        required :attributes,
                 -> { OpenAI::HashOf[union: OpenAI::Models::VectorStores::FileUpdateParams::Attribute] },
                 nil?: true

        # @!parse
        #   # @param vector_store_id [String]
        #   # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(vector_store_id:, attributes:, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        class Attribute < OpenAI::Union
          variant String

          variant Float

          variant OpenAI::BooleanModel
        end
      end
    end
  end
end
