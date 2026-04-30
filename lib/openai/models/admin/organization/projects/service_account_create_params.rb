# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#create
          class ServiceAccountCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute name
            #   The name of the service account being created.
            #
            #   @return [String]
            required :name, String

            # @!method initialize(project_id:, name:, request_options: {})
            #   @param project_id [String]
            #
            #   @param name [String] The name of the service account being created.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
