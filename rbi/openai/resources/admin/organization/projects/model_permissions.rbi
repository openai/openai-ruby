# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ModelPermissions
            # Returns model permissions for a project.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectModelPermissions
              )
            end
            def retrieve(
              # The ID of the project.
              project_id,
              request_options: {}
            )
            end

            # Updates model permissions for a project.
            sig do
              params(
                project_id: String,
                mode:
                  OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::OrSymbol,
                model_ids: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectModelPermissions
              )
            end
            def update(
              # The ID of the project.
              project_id,
              # The model permissions mode to apply.
              mode:,
              # The model IDs included in this permissions policy.
              model_ids:,
              request_options: {}
            )
            end

            # Deletes model permissions for a project.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectModelPermissionsDeleted
              )
            end
            def delete(
              # The ID of the project.
              project_id,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end
        end
      end
    end
  end
end
