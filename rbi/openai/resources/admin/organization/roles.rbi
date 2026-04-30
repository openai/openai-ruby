# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Roles
          # Creates a custom role for the organization.
          sig do
            params(
              permissions: T::Array[String],
              role_name: String,
              description: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Role)
          end
          def create(
            # Permissions to grant to the role.
            permissions:,
            # Unique name for the role.
            role_name:,
            # Optional description of the role.
            description: nil,
            request_options: {}
          )
          end

          # Updates an existing organization role.
          sig do
            params(
              role_id: String,
              description: T.nilable(String),
              permissions: T.nilable(T::Array[String]),
              role_name: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Role)
          end
          def update(
            # The ID of the role to update.
            role_id,
            # New description for the role.
            description: nil,
            # Updated set of permissions for the role.
            permissions: nil,
            # New name for the role.
            role_name: nil,
            request_options: {}
          )
          end

          # Lists the roles configured for the organization.
          sig do
            params(
              after: String,
              limit: Integer,
              order:
                OpenAI::Admin::Organization::RoleListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::Role]
            )
          end
          def list(
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

          # Deletes a custom role from the organization.
          sig do
            params(
              role_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::RoleDeleteResponse)
          end
          def delete(
            # The ID of the role to delete.
            role_id,
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
