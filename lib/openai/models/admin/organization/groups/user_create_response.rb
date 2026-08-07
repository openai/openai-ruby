# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#create
          class UserCreateResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute group_id
            #   Identifier of the group the user was added to.
            #
            #   @return [String]
            required :group_id, String

            # @!attribute object
            #   Always `group.user`.
            #
            #   @return [Symbol, :"group.user"]
            required :object, const: :"group.user"

            # @!attribute user_id
            #   Identifier of the user that was added.
            #
            #   @return [String]
            required :user_id, String

            # @!method initialize(group_id:, user_id:, object: :"group.user")
            #   Confirmation payload returned after adding a user to a group.
            #
            #   @param group_id [String] Identifier of the group the user was added to.
            #
            #   @param user_id [String] Identifier of the user that was added.
            #
            #   @param object [Symbol, :"group.user"] Always `group.user`.
          end
        end
      end
    end
  end
end
