# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Users
            # @see OpenAI::Resources::Admin::Organization::Projects::Users::Roles#create
            class RoleCreateResponse < OpenAI::Internal::Type::BaseModel
              # @!attribute object
              #   Always `user.role`.
              #
              #   @return [Symbol, :"user.role"]
              required :object, const: :"user.role"

              # @!attribute role
              #   Details about a role that can be assigned through the public Roles API.
              #
              #   @return [OpenAI::Models::Admin::Organization::Role]
              required :role, -> { OpenAI::Admin::Organization::Role }

              # @!attribute user
              #   Represents an individual `user` within an organization.
              #
              #   @return [OpenAI::Models::Admin::Organization::OrganizationUser]
              required :user, -> { OpenAI::Admin::Organization::OrganizationUser }

              # @!method initialize(role:, user:, object: :"user.role")
              #   Role assignment linking a user to a role.
              #
              #   @param role [OpenAI::Models::Admin::Organization::Role] Details about a role that can be assigned through the public Roles API.
              #
              #   @param user [OpenAI::Models::Admin::Organization::OrganizationUser] Represents an individual `user` within an organization.
              #
              #   @param object [Symbol, :"user.role"] Always `user.role`.
            end
          end
        end
      end
    end
  end
end
