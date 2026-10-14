# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#delete
          class UserDeleteResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute deleted
            #   Whether the group membership was removed.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   Always `group.user.deleted`.
            #
            #   @return [Symbol, :"group.user.deleted"]
            required :object, const: :"group.user.deleted"

            # @!method initialize(deleted:, object: :"group.user.deleted")
            #   Confirmation payload returned after removing a user from a group.
            #
            #   @param deleted [Boolean] Whether the group membership was removed.
            #
            #   @param object [Symbol, :"group.user.deleted"] Always `group.user.deleted`.
          end
        end
      end
    end
  end
end
