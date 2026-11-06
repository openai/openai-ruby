# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#create
          class FederationRuleCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute workload_identity_provider_id
            #
            #   @return [String]
            required :workload_identity_provider_id, String

            # @!attribute attribute_matchers
            #
            #   @return [Hash{Symbol=>String, Boolean, Integer, Float}]
            required(
              :attribute_matchers,
              -> {
                OpenAI::Internal::Type::HashOf[
                  union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher
                ]
              }
            )

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute service_account_id
            #
            #   @return [String]
            required :service_account_id, String

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String

            # @!attribute enabled
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute name
            #
            #   @return [String, nil]
            optional :name, String

            # @!attribute permissions
            #
            #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted, nil]
            optional(
              :permissions,
              union: -> {
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions
              }
            )

            # @!method initialize(workload_identity_provider_id:, attribute_matchers:, project_id:, service_account_id:, description: nil, enabled: nil, name: nil, permissions: nil, request_options: {})
            #   @param workload_identity_provider_id [String]
            #   @param attribute_matchers [Hash{Symbol=>String, Boolean, Integer, Float}]
            #   @param project_id [String]
            #   @param service_account_id [String]
            #   @param description [String]
            #   @param enabled [Boolean]
            #   @param name [String]
            #   @param permissions [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted]
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

              discriminator :type

              variant(
                :service_account_default,
                -> {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault
                }
              )

              variant(
                :restricted,
                -> {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted
                }
              )

              class ServiceAccountDefault < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #
                #   @return [Symbol, :service_account_default]
                required :type, const: :service_account_default

                # @!method initialize(type: :service_account_default)
                #   @param type [Symbol, :service_account_default]
              end

              class Restricted < OpenAI::Internal::Type::BaseModel
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
              #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted)]
            end
          end
        end
      end
    end
  end
end
