# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#delete
          class ServiceAccountDeleteResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #
            #   @return [String]
            required :id, String

            # @!attribute deleted
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #
            #   @return [Symbol, :"organization.project.service_account.deleted"]
            required :object, const: :"organization.project.service_account.deleted"

            # @!method initialize(id:, deleted:, object: :"organization.project.service_account.deleted")
            #   @param id [String]
            #   @param deleted [Boolean]
            #   @param object [Symbol, :"organization.project.service_account.deleted"]
          end
        end
      end
    end
  end
end
