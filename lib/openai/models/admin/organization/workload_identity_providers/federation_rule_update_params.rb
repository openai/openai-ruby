# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#update
          class FederationRuleUpdateParams < OpenAI::Internal::Type::BaseModel
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

            # @!attribute attribute_matchers
            #
            #   @return [Hash{Symbol=>String, Boolean, Integer, Float}, nil]
            optional(
              :attribute_matchers,
              -> {
                OpenAI::Internal::Type::HashOf[
                  union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher
                ]
              }
            )

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String, nil?: true

            # @!attribute enabled
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute name
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute permissions
            #
            #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam, nil]
            optional(
              :permissions,
              union: -> {
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions
              }
            )

            # @!method initialize(workload_identity_provider_id:, workload_identity_federation_rule_id:, attribute_matchers: nil, description: nil, enabled: nil, name: nil, permissions: nil, request_options: {})
            #   @param workload_identity_provider_id [String]
            #   @param workload_identity_federation_rule_id [String]
            #   @param attribute_matchers [Hash{Symbol=>String, Boolean, Integer, Float}]
            #   @param description [String, nil]
            #   @param enabled [Boolean]
            #   @param name [String, nil]
            #   @param permissions [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            module AttributeMatcher
              extend OpenAI::Internal::Type::Union

              variant String

              variant OpenAI::Internal::Type::Boolean

              variant Integer

              variant Float

              # @!method self.variants
              #   @return [Array(String, Boolean, Integer, Float)]
            end

            module Permissions
              extend OpenAI::Internal::Type::Union

              variant(
                -> {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam
                }
              )

              variant(
                -> {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam
                }
              )

              class DefaultPermissionsParam < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #
                #   @return [Symbol, :service_account_default]
                required :type, const: :service_account_default

                # @!method initialize(type: :service_account_default)
                #   @param type [Symbol, :service_account_default]
              end

              class RestrictedPermissionsParam < OpenAI::Internal::Type::BaseModel
                # @!attribute scopes
                #
                #   @return [Array<String>]
                required :scopes, OpenAI::Internal::Type::ArrayOf[String]

                # @!attribute type
                #
                #   @return [Symbol, :restricted]
                required :type, const: :restricted

                # @!method initialize(scopes:, type: :restricted)
                #   @param scopes [Array<String>]
                #   @param type [Symbol, :restricted]
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam)]
            end
          end
        end
      end
    end
  end
end
