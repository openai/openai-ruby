# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::SpendAlerts#delete
          class ProjectSpendAlertDeleted < OpenAI::Internal::Type::BaseModel
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
            #   Always `project.spend_alert.deleted`.
            #
            #   @return [Symbol, :"project.spend_alert.deleted"]
            required :object, const: :"project.spend_alert.deleted"

            # @!method initialize(id:, deleted:, object: :"project.spend_alert.deleted")
            #   Confirmation payload returned after deleting a project spend alert.
            #
            #   @param id [String] The deleted spend alert ID.
            #
            #   @param deleted [Boolean] Whether the spend alert was deleted.
            #
            #   @param object [Symbol, :"project.spend_alert.deleted"] Always `project.spend_alert.deleted`.
          end
        end

        ProjectSpendAlertDeleted = Projects::ProjectSpendAlertDeleted
      end
    end
  end
end
