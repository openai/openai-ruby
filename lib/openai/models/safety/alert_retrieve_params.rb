# frozen_string_literal: true

module OpenAI
  module Models
    module Safety
      # @see OpenAI::Resources::Safety::Alerts#retrieve
      class AlertRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute id
        #   Project safety alert ID
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:, request_options: {})
        #   @param id [String] Project safety alert ID
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
