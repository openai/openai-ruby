# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#update
        class CertificateUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute certificate_id
          #
          #   @return [String]
          required :certificate_id, String

          # @!attribute name
          #   The updated name for the certificate
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(certificate_id:, name: nil, request_options: {})
          #   @param certificate_id [String]
          #
          #   @param name [String] The updated name for the certificate
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
