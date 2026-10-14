# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#activate
        class CertificateActivateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute certificate_ids
          #
          #   @return [Array<String>]
          required :certificate_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(certificate_ids:, request_options: {})
          #   @param certificate_ids [Array<String>]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
