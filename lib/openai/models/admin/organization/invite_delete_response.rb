# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Invites#delete
        class InviteDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   The object type, which is always `organization.invite.deleted`
          #
          #   @return [Symbol, :"organization.invite.deleted"]
          required :object, const: :"organization.invite.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.invite.deleted")
          #   @param id [String]
          #
          #   @param deleted [Boolean]
          #
          #   @param object [Symbol, :"organization.invite.deleted"] The object type, which is always `organization.invite.deleted`
        end
      end
    end
  end
end
