# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ModelPermissions#delete
          class ProjectModelPermissionsDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute deleted
            #   Whether the project model permissions were deleted.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   The object type, which is always `project.model_permissions.deleted`.
            #
            #   @return [Symbol, :"project.model_permissions.deleted"]
            required :object, const: :"project.model_permissions.deleted"

            # @!method initialize(deleted:, object: :"project.model_permissions.deleted")
            #   Confirmation payload returned after deleting project model permissions.
            #
            #   @param deleted [Boolean] Whether the project model permissions were deleted.
            #
            #   @param object [Symbol, :"project.model_permissions.deleted"] The object type, which is always `project.model_permissions.deleted`.
          end
        end

        ProjectModelPermissionsDeleted = Projects::ProjectModelPermissionsDeleted
      end
    end
  end
end
