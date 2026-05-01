# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Groups#create
          class ProjectGroup < OpenAI::Internal::Type::BaseModel
            # @!attribute created_at
            #   Unix timestamp (in seconds) when the group was granted project access.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute group_id
            #   Identifier of the group that has access to the project.
            #
            #   @return [String]
            required :group_id, String

            # @!attribute group_name
            #   Display name of the group.
            #
            #   @return [String]
            required :group_name, String

            # @!attribute group_type
            #   The type of the group.
            #
            #   @return [String]
            required :group_type, String

            # @!attribute object
            #   Always `project.group`.
            #
            #   @return [Symbol, :"project.group"]
            required :object, const: :"project.group"

            # @!attribute project_id
            #   Identifier of the project.
            #
            #   @return [String]
            required :project_id, String

            # @!method initialize(created_at:, group_id:, group_name:, group_type:, project_id:, object: :"project.group")
            #   Details about a group's membership in a project.
            #
            #   @param created_at [Integer] Unix timestamp (in seconds) when the group was granted project access.
            #
            #   @param group_id [String] Identifier of the group that has access to the project.
            #
            #   @param group_name [String] Display name of the group.
            #
            #   @param group_type [String] The type of the group.
            #
            #   @param project_id [String] Identifier of the project.
            #
            #   @param object [Symbol, :"project.group"] Always `project.group`.
          end
        end

        ProjectGroup = Projects::ProjectGroup
      end
    end
  end
end
