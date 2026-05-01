# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Users
          class Roles
            # Assigns an organization role to a user within the organization.
            sig do
              params(
                user_id: String,
                role_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Users::RoleCreateResponse
              )
            end
            def create(
              # The ID of the user that should receive the organization role.
              user_id,
              # Identifier of the role to assign.
              role_id:,
              request_options: {}
            )
            end

            # Lists the organization roles assigned to a user within the organization.
            sig do
              params(
                user_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::NextCursorPage[
                  OpenAI::Models::Admin::Organization::Users::RoleListResponse
                ]
              )
            end
            def list(
              # The ID of the user to inspect.
              user_id,
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

            # Unassigns an organization role from a user within the organization.
            sig do
              params(
                role_id: String,
                user_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Users::RoleDeleteResponse
              )
            end
            def delete(
              # The ID of the organization role to remove from the user.
              role_id,
              # The ID of the user to modify.
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
