# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::SpendLimit#delete
          class ProjectSpendLimitDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute deleted
            #   Whether the hard spend limit was deleted.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   The object type, which is always `project.spend_limit.deleted`.
            #
            #   @return [Symbol, :"project.spend_limit.deleted"]
            required :object, const: :"project.spend_limit.deleted"

            # @!method initialize(deleted:, object: :"project.spend_limit.deleted")
            #   Confirmation payload returned after deleting a project hard spend limit.
            #
            #   @param deleted [Boolean] Whether the hard spend limit was deleted.
            #
            #   @param object [Symbol, :"project.spend_limit.deleted"] The object type, which is always `project.spend_limit.deleted`.
          end
        end

        ProjectSpendLimitDeleted = Projects::ProjectSpendLimitDeleted
      end
    end
  end
end
