# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Groups#delete
        class GroupDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the deleted group.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Whether the group was deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   Always `group.deleted`.
          #
          #   @return [Symbol, :"group.deleted"]
          required :object, const: :"group.deleted"

          # @!method initialize(id:, deleted:, object: :"group.deleted")
          #   Confirmation payload returned after deleting a group.
          #
          #   @param id [String] Identifier of the deleted group.
          #
          #   @param deleted [Boolean] Whether the group was deleted.
          #
          #   @param object [Symbol, :"group.deleted"] Always `group.deleted`.
        end
      end
    end
  end
end
