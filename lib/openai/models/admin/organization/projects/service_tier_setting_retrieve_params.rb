# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceTierSettings#retrieve
          class ServiceTierSettingRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #   The ID of the project
            #
            #   @return [String]
            required :project_id, String

            # @!method initialize(project_id:, request_options: {})
            #   @param project_id [String]
            #     The ID of the project
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
