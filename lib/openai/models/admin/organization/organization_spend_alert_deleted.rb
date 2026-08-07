# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendAlerts#delete
        class OrganizationSpendAlertDeleted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The deleted spend alert ID.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Whether the spend alert was deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   Always `organization.spend_alert.deleted`.
          #
          #   @return [Symbol, :"organization.spend_alert.deleted"]
          required :object, const: :"organization.spend_alert.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.spend_alert.deleted")
          #   Confirmation payload returned after deleting an organization spend alert.
          #
          #   @param id [String] The deleted spend alert ID.
          #
          #   @param deleted [Boolean] Whether the spend alert was deleted.
          #
          #   @param object [Symbol, :"organization.spend_alert.deleted"] Always `organization.spend_alert.deleted`.
        end
      end

      OrganizationSpendAlertDeleted = Organization::OrganizationSpendAlertDeleted
    end
  end
end
