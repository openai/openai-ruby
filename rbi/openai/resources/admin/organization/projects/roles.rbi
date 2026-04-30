# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Roles
            # Creates a custom role for a project.
            sig do
              params(
                project_id: String,
                permissions: T::Array[String],
                role_name: String,
                description: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Role)
            end
            def create(
              # The ID of the project to update.
              project_id,
              # Permissions to grant to the role.
              permissions:,
              # Unique name for the role.
              role_name:,
              # Optional description of the role.
              description: nil,
              request_options: {}
            )
            end

            # Updates an existing project role.
            sig do
              params(
                role_id: String,
                project_id: String,
                description: T.nilable(String),
                permissions: T.nilable(T::Array[String]),
                role_name: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Role)
            end
            def update(
              # Path param: The ID of the role to update.
              role_id,
              # Path param: The ID of the project to update.
              project_id:,
              # Body param: New description for the role.
              description: nil,
              # Body param: Updated set of permissions for the role.
              permissions: nil,
              # Body param: New name for the role.
              role_name: nil,
              request_options: {}
            )
            end

            # Lists the roles configured for a project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::RoleListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::Role]
              )
            end
            def list(
              # The ID of the project to inspect.
              project_id,
              # Cursor for pagination. Provide the value from the previous response's `next`
              # field to continue listing roles.
              after: nil,
              # A limit on the number of roles to return. Defaults to 1000.
              limit: nil,
              # Sort order for the returned roles.
              order: nil,
              request_options: {}
            )
            end

            # Deletes a custom role from a project.
            sig do
              params(
                role_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::RoleDeleteResponse
              )
            end
            def delete(
              # The ID of the role to delete.
              role_id,
              # The ID of the project to update.
              project_id:,
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
