# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectModelPermissionsDeleted =
          Projects::ProjectModelPermissionsDeleted

        module Projects
          class ProjectModelPermissionsDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectModelPermissionsDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the project model permissions were deleted.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # The object type, which is always `project.model_permissions.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after deleting project model permissions.
            sig do
              params(deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Whether the project model permissions were deleted.
              deleted:,
              # The object type, which is always `project.model_permissions.deleted`.
              object: :"project.model_permissions.deleted"
            )
            end

            sig { override.returns({ deleted: T::Boolean, object: Symbol }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
