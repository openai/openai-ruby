# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#delete
      class ResponseDeleteParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!parse
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
