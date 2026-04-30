# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          class Roles
            # Assigns an organization role to a group within the organization.
            sig do
              params(
                group_id: String,
                role_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Groups::RoleCreateResponse
              )
            end
            def create(
              # The ID of the group that should receive the organization role.
              group_id,
              # Identifier of the role to assign.
              role_id:,
              request_options: {}
            )
            end

            # Lists the organization roles assigned to a group within the organization.
            sig do
              params(
                group_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Groups::RoleListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::CursorPage[
                  OpenAI::Models::Admin::Organization::Groups::RoleListResponse
                ]
              )
            end
            def list(
              # The ID of the group whose organization role assignments you want to list.
              group_id,
              # Cursor for pagination. Provide the value from the previous response's `next`
              # field to continue listing organization roles.
              after: nil,
              # A limit on the number of organization role assignments to return.
              limit: nil,
              # Sort order for the returned organization roles.
              order: nil,
              request_options: {}
            )
            end

            # Unassigns an organization role from a group within the organization.
            sig do
              params(
                role_id: String,
                group_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Groups::RoleDeleteResponse
              )
            end
            def delete(
              # The ID of the organization role to remove from the group.
              role_id,
              # The ID of the group to modify.
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
