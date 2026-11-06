# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders#delete
        class WorkloadIdentityProviderDeleted < OpenAI::Internal::Type::BaseModel
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
          #   @return [Symbol, :"organization.workload_identity_provider.deleted"]
          required :object, const: :"organization.workload_identity_provider.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.workload_identity_provider.deleted")
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [Symbol, :"organization.workload_identity_provider.deleted"]
        end
      end
    end
  end
end
