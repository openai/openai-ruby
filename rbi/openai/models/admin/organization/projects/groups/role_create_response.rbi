# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Groups
            class RoleCreateResponse < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Summary information about a group returned in role assignment responses.
              sig do
                returns(
                  OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group
                )
              end
              attr_reader :group

              sig do
                params(
                  group:
                    OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group::OrHash
                ).void
              end
              attr_writer :group

              # Always `group.role`.
              sig { returns(Symbol) }
              attr_accessor :object

              # Details about a role that can be assigned through the public Roles API.
              sig { returns(OpenAI::Admin::Organization::Role) }
              attr_reader :role

              sig do
                params(role: OpenAI::Admin::Organization::Role::OrHash).void
              end
              attr_writer :role

              # Role assignment linking a group to a role.
              sig do
                params(
                  group:
                    OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group::OrHash,
                  role: OpenAI::Admin::Organization::Role::OrHash,
                  object: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Summary information about a group returned in role assignment responses.
                group:,
                # Details about a role that can be assigned through the public Roles API.
                role:,
                # Always `group.role`.
                object: :"group.role"
              )
              end

              sig do
                override.returns(
                  {
                    group:
                      OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group,
                    object: Symbol,
                    role: OpenAI::Admin::Organization::Role
                  }
                )
              end
              def to_hash
              end

              class Group < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Identifier for the group.
                sig { returns(String) }
                attr_accessor :id

                # Unix timestamp (in seconds) when the group was created.
                sig { returns(Integer) }
                attr_accessor :created_at

                # Display name of the group.
                sig { returns(String) }
                attr_accessor :name

                # Always `group`.
                sig { returns(Symbol) }
                attr_accessor :object

                # Whether the group is managed through SCIM.
                sig { returns(T::Boolean) }
                attr_accessor :scim_managed

                # Summary information about a group returned in role assignment responses.
                sig do
                  params(
                    id: String,
                    created_at: Integer,
                    name: String,
                    scim_managed: T::Boolean,
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Identifier for the group.
                  id:,
                  # Unix timestamp (in seconds) when the group was created.
                  created_at:,
                  # Display name of the group.
                  name:,
                  # Whether the group is managed through SCIM.
                  scim_managed:,
                  # Always `group`.
                  object: :group
                )
                end

                sig do
                  override.returns(
                    {
                      id: String,
                      created_at: Integer,
                      name: String,
                      object: Symbol,
                      scim_managed: T::Boolean
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
  end
end
