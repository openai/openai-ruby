# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Certificates#deactivate
          class CertificateDeactivateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute certificate_ids
            #
            #   @return [Array<String>]
            required :certificate_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(project_id:, certificate_ids:, request_options: {})
            #   @param project_id [String]
            #   @param certificate_ids [Array<String>]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
