# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Groups
            sig do
              returns(
                OpenAI::Resources::Admin::Organization::Projects::Groups::Roles
              )
            end
            attr_reader :roles

            # Grants a group access to a project.
            sig do
              params(
                project_id: String,
                group_id: String,
                role: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectGroup)
            end
            def create(
              # The ID of the project to update.
              project_id,
              # Identifier of the group to add to the project.
              group_id:,
              # Identifier of the project role to grant to the group.
              role:,
              request_options: {}
            )
            end

            # Lists the groups that have access to a project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::CursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectGroup
                ]
              )
            end
            def list(
              # The ID of the project to inspect.
              project_id,
              # Cursor for pagination. Provide the ID of the last group from the previous
              # response to fetch the next page.
              after: nil,
              # A limit on the number of project groups to return. Defaults to 20.
              limit: nil,
              # Sort order for the returned groups.
              order: nil,
              request_options: {}
            )
            end

            # Revokes a group's access to a project.
            sig do
              params(
                group_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::GroupDeleteResponse
              )
            end
            def delete(
              # The ID of the group to remove from the project.
              group_id,
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
