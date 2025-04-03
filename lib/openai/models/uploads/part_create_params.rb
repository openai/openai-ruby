# frozen_string_literal: true

module OpenAI
  module Models
    module Uploads
      # @see OpenAI::Resources::Uploads::Parts#create
      class PartCreateParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute data
        #   The chunk of bytes for this Part.
        #
        #   @return [IO, StringIO]
        required :data, IO

        # @!parse
        #   # @param data [IO, StringIO]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(data:, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
