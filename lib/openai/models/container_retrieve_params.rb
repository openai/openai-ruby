# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Containers#retrieve
    class ContainerRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute container_id
      #
      #   @return [String]
      required :container_id, String

      # @!method initialize(container_id:, request_options: {})
      #   @param container_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
