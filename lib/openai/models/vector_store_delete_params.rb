# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#delete
    class VectorStoreDeleteParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!parse
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
