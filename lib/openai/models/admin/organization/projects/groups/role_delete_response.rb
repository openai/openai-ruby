# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Groups
            # @see OpenAI::Resources::Admin::Organization::Projects::Groups::Roles#delete
            class RoleDeleteResponse < OpenAI::Internal::Type::BaseModel
              # @!attribute deleted
              #   Whether the assignment was removed.
              #
              #   @return [Boolean]
              required :deleted, OpenAI::Internal::Type::Boolean

              # @!attribute object
              #   Identifier for the deleted assignment, such as `group.role.deleted` or
              #   `user.role.deleted`.
              #
              #   @return [String]
              required :object, String

              # @!method initialize(deleted:, object:)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteResponse} for
              #   more details.
              #
              #   Confirmation payload returned after unassigning a role.
              #
              #   @param deleted [Boolean] Whether the assignment was removed.
              #
              #   @param object [String] Identifier for the deleted assignment, such as `group.role.deleted` or `user.rol
            end
          end
        end
      end
    end
  end
end
