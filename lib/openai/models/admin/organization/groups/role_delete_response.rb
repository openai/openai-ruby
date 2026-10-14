# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Roles#delete
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
            #   Confirmation payload returned after unassigning a role.
            #
            #   @param deleted [Boolean]
            #     Whether the assignment was removed.
            #
            #   @param object [String]
            #     Identifier for the deleted assignment, such as `group.role.deleted` or
            #     `user.role.deleted`.
          end
        end
      end
    end
  end
end
