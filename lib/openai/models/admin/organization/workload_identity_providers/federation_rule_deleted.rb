# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#delete
          class FederationRuleDeleted < OpenAI::Internal::Type::BaseModel
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
            #   @return [Symbol, :"organization.workload_identity_federation_rule.deleted"]
            required :object, const: :"organization.workload_identity_federation_rule.deleted"

            # @!method initialize(id:, deleted:, object: :"organization.workload_identity_federation_rule.deleted")
            #   @param id [String]
            #   @param deleted [Boolean]
            #   @param object [Symbol, :"organization.workload_identity_federation_rule.deleted"]
          end
        end
      end
    end
  end
end
