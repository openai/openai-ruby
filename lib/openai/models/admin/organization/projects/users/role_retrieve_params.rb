# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Users
            # @see OpenAI::Resources::Admin::Organization::Projects::Users::Roles#retrieve
            class RoleRetrieveParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              # @!attribute project_id
              #
              #   @return [String]
              required :project_id, String

              # @!attribute user_id
              #
              #   @return [String]
              required :user_id, String

              # @!attribute role_id
              #
              #   @return [String]
              required :role_id, String

              # @!method initialize(project_id:, user_id:, role_id:, request_options: {})
              #   @param project_id [String]
              #   @param user_id [String]
              #   @param role_id [String]
              #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
            end
          end
        end
      end
    end
  end
end
