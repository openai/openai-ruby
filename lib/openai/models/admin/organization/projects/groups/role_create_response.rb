# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Groups
            # @see OpenAI::Resources::Admin::Organization::Projects::Groups::Roles#create
            class RoleCreateResponse < OpenAI::Internal::Type::BaseModel
              # @!attribute group
              #   Summary information about a group returned in role assignment responses.
              #
              #   @return [OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group]
              required :group, -> { OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group }

              # @!attribute object
              #   Always `group.role`.
              #
              #   @return [Symbol, :"group.role"]
              required :object, const: :"group.role"

              # @!attribute role
              #   Details about a role that can be assigned through the public Roles API.
              #
              #   @return [OpenAI::Models::Admin::Organization::Role]
              required :role, -> { OpenAI::Admin::Organization::Role }

              # @!method initialize(group:, role:, object: :"group.role")
              #   Role assignment linking a group to a role.
              #
              #   @param group [OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group] Summary information about a group returned in role assignment responses.
              #
              #   @param role [OpenAI::Models::Admin::Organization::Role] Details about a role that can be assigned through the public Roles API.
              #
              #   @param object [Symbol, :"group.role"] Always `group.role`.

              # @see OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse#group
              class Group < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   Identifier for the group.
                #
                #   @return [String]
                required :id, String

                # @!attribute created_at
                #   Unix timestamp (in seconds) when the group was created.
                #
                #   @return [Integer]
                required :created_at, Integer

                # @!attribute name
                #   Display name of the group.
                #
                #   @return [String]
                required :name, String

                # @!attribute object
                #   Always `group`.
                #
                #   @return [Symbol, :group]
                required :object, const: :group

                # @!attribute scim_managed
                #   Whether the group is managed through SCIM.
                #
                #   @return [Boolean]
                required :scim_managed, OpenAI::Internal::Type::Boolean

                # @!method initialize(id:, created_at:, name:, scim_managed:, object: :group)
                #   Summary information about a group returned in role assignment responses.
                #
                #   @param id [String] Identifier for the group.
                #
                #   @param created_at [Integer] Unix timestamp (in seconds) when the group was created.
                #
                #   @param name [String] Display name of the group.
                #
                #   @param scim_managed [Boolean] Whether the group is managed through SCIM.
                #
                #   @param object [Symbol, :group] Always `group`.
              end
            end
          end
        end
      end
    end
  end
end
