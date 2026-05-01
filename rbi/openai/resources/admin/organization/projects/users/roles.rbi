# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Users
            class Roles
              # Assigns a project role to a user within a project.
              sig do
                params(
                  user_id: String,
                  project_id: String,
                  role_id: String,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Models::Admin::Organization::Projects::Users::RoleCreateResponse
                )
              end
              def create(
                # Path param: The ID of the user that should receive the project role.
                user_id,
                # Path param: The ID of the project to update.
                project_id:,
                # Body param: Identifier of the role to assign.
                role_id:,
                request_options: {}
              )
              end

              # Lists the project roles assigned to a user within a project.
              sig do
                params(
                  user_id: String,
                  project_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Projects::Users::RoleListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Internal::NextCursorPage[
                    OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse
                  ]
                )
              end
              def list(
                # Path param: The ID of the user to inspect.
                user_id,
                # Path param: The ID of the project to inspect.
                project_id:,
                # Query param: Cursor for pagination. Provide the value from the previous
                # response's `next` field to continue listing project roles.
                after: nil,
                # Query param: A limit on the number of project role assignments to return.
                limit: nil,
                # Query param: Sort order for the returned project roles.
                order: nil,
                request_options: {}
              )
              end

              # Unassigns a project role from a user within a project.
              sig do
                params(
                  role_id: String,
                  project_id: String,
                  user_id: String,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Models::Admin::Organization::Projects::Users::RoleDeleteResponse
                )
              end
              def delete(
                # The ID of the project role to remove from the user.
                role_id,
                # The ID of the project to modify.
                project_id:,
                # The ID of the user whose project role assignment should be removed.
                user_id:,
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
end
