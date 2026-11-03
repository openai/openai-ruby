# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#retrieve
          class FederationRuleRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute workload_identity_provider_id
            #
            #   @return [String]
            required :workload_identity_provider_id, String

            # @!attribute workload_identity_federation_rule_id
            #
            #   @return [String]
            required :workload_identity_federation_rule_id, String

            # @!method initialize(workload_identity_provider_id:, workload_identity_federation_rule_id:, request_options: {})
            #   @param workload_identity_provider_id [String]
            #   @param workload_identity_federation_rule_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
