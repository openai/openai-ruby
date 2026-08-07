# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#create
        class CertificateCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute certificate
          #   The certificate content in PEM format
          #
          #   @return [String]
          required :certificate, String

          # @!attribute name
          #   An optional name for the certificate
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(certificate:, name: nil, request_options: {})
          #   @param certificate [String] The certificate content in PEM format
          #
          #   @param name [String] An optional name for the certificate
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
