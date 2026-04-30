# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Groups
            class Roles
              # Assigns a project role to a group within a project.
              sig do
                params(
                  group_id: String,
                  project_id: String,
                  role_id: String,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse
                )
              end
              def create(
                # Path param: The ID of the group that should receive the project role.
                group_id,
                # Path param: The ID of the project to update.
                project_id:,
                # Body param: Identifier of the role to assign.
                role_id:,
                request_options: {}
              )
              end

              # Lists the project roles assigned to a group within a project.
              sig do
                params(
                  group_id: String,
                  project_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Internal::CursorPage[
                    OpenAI::Models::Admin::Organization::Projects::Groups::RoleListResponse
                  ]
                )
              end
              def list(
                # Path param: The ID of the group to inspect.
                group_id,
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

              # Unassigns a project role from a group within a project.
              sig do
                params(
                  role_id: String,
                  project_id: String,
                  group_id: String,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteResponse
                )
              end
              def delete(
                # The ID of the project role to remove from the group.
                role_id,
                # The ID of the project to modify.
                project_id:,
                # The ID of the group whose project role assignment should be removed.
                group_id:,
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
