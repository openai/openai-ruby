# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#delete
      class ResponseDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute response_id
        #
        #   @return [String]
        required :response_id, String

        # @!method initialize(response_id:, request_options: {})
        #   @param response_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
