# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#retrieve
          class ServiceAccountRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute service_account_id
            #
            #   @return [String]
            required :service_account_id, String

            # @!method initialize(project_id:, service_account_id:, request_options: {})
            #   @param project_id [String]
            #   @param service_account_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
