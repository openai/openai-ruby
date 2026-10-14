# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Roles#delete
        class RoleDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the deleted role.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Whether the role was deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   Always `role.deleted`.
          #
          #   @return [Symbol, :"role.deleted"]
          required :object, const: :"role.deleted"

          # @!method initialize(id:, deleted:, object: :"role.deleted")
          #   Confirmation payload returned after deleting a role.
          #
          #   @param id [String] Identifier of the deleted role.
          #
          #   @param deleted [Boolean] Whether the role was deleted.
          #
          #   @param object [Symbol, :"role.deleted"] Always `role.deleted`.
        end
      end
    end
  end
end
