# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendLimit#delete
        class OrganizationSpendLimitDeleted < OpenAI::Internal::Type::BaseModel
          # @!attribute deleted
          #   Whether the hard spend limit was deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   The object type, which is always `organization.spend_limit.deleted`.
          #
          #   @return [Symbol, :"organization.spend_limit.deleted"]
          required :object, const: :"organization.spend_limit.deleted"

          # @!method initialize(deleted:, object: :"organization.spend_limit.deleted")
          #   Confirmation payload returned after deleting an organization hard spend limit.
          #
          #   @param deleted [Boolean] Whether the hard spend limit was deleted.
          #
          #   @param object [Symbol, :"organization.spend_limit.deleted"] The object type, which is always `organization.spend_limit.deleted`.
        end
      end

      OrganizationSpendLimitDeleted = Organization::OrganizationSpendLimitDeleted
    end
  end
end
