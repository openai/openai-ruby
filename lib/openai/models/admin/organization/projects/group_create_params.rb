# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Groups#create
          class GroupCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute group_id
            #   Identifier of the group to add to the project.
            #
            #   @return [String]
            required :group_id, String

            # @!attribute role
            #   Identifier of the project role to grant to the group.
            #
            #   @return [String]
            required :role, String

            # @!method initialize(project_id:, group_id:, role:, request_options: {})
            #   @param project_id [String]
            #
            #   @param group_id [String] Identifier of the group to add to the project.
            #
            #   @param role [String] Identifier of the project role to grant to the group.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
