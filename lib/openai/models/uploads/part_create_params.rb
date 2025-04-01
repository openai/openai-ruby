# frozen_string_literal: true

module OpenAI
  module Models
    module Uploads
      # @see OpenAI::Resources::Uploads::Parts#create
      class PartCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

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

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
