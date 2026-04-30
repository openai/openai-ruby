# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Users
          class RoleCreateResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Users::RoleCreateResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Always `user.role`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Details about a role that can be assigned through the public Roles API.
            sig { returns(OpenAI::Admin::Organization::Role) }
            attr_reader :role

            sig { params(role: OpenAI::Admin::Organization::Role::OrHash).void }
            attr_writer :role

            # Represents an individual `user` within an organization.
            sig { returns(OpenAI::Admin::Organization::OrganizationUser) }
            attr_reader :user

            sig do
              params(
                user: OpenAI::Admin::Organization::OrganizationUser::OrHash
              ).void
            end
            attr_writer :user

            # Role assignment linking a user to a role.
            sig do
              params(
                role: OpenAI::Admin::Organization::Role::OrHash,
                user: OpenAI::Admin::Organization::OrganizationUser::OrHash,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Details about a role that can be assigned through the public Roles API.
              role:,
              # Represents an individual `user` within an organization.
              user:,
              # Always `user.role`.
              object: :"user.role"
            )
            end

            sig do
              override.returns(
                {
                  object: Symbol,
                  role: OpenAI::Admin::Organization::Role,
                  user: OpenAI::Admin::Organization::OrganizationUser
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
