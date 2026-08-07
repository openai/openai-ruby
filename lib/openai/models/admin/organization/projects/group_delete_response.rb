# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Groups#delete
          class GroupDeleteResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute deleted
            #   Whether the group membership in the project was removed.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   Always `project.group.deleted`.
            #
            #   @return [Symbol, :"project.group.deleted"]
            required :object, const: :"project.group.deleted"

            # @!method initialize(deleted:, object: :"project.group.deleted")
            #   Confirmation payload returned after removing a group from a project.
            #
            #   @param deleted [Boolean] Whether the group membership in the project was removed.
            #
            #   @param object [Symbol, :"project.group.deleted"] Always `project.group.deleted`.
          end
        end
      end
    end
  end
end
