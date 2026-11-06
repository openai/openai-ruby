# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#create
          class FederationRule < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #
            #   @return [String]
            required :id, String

            # @!attribute attribute_matchers
            #
            #   @return [Hash{Symbol=>String, Boolean, Integer, Float}]
            required(
              :attribute_matchers,
              -> {
                OpenAI::Internal::Type::HashOf[
                  union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher
                ]
              }
            )

            # @!attribute created_at
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute description
            #
            #   @return [String, nil]
            required :description, String, nil?: true

            # @!attribute enabled
            #
            #   @return [Boolean]
            required :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute name
            #
            #   @return [String, nil]
            required :name, String, nil?: true

            # @!attribute object
            #
            #   @return [Symbol, :"organization.workload_identity_federation_rule"]
            required :object, const: :"organization.workload_identity_federation_rule"

            # @!attribute permissions
            #
            #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted]
            required(
              :permissions,
              union: -> { OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions }
            )

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute service_account_id
            #
            #   @return [String]
            required :service_account_id, String

            # @!attribute updated_at
            #
            #   @return [Integer]
            required :updated_at, Integer

            # @!attribute workload_identity_provider_id
            #
            #   @return [String]
            required :workload_identity_provider_id, String

            # @!method initialize(id:, attribute_matchers:, created_at:, description:, enabled:, name:, permissions:, project_id:, service_account_id:, updated_at:, workload_identity_provider_id:, object: :"organization.workload_identity_federation_rule")
            #   @param id [String]
            #   @param attribute_matchers [Hash{Symbol=>String, Boolean, Integer, Float}]
            #   @param created_at [Integer]
            #   @param description [String, nil]
            #   @param enabled [Boolean]
            #   @param name [String, nil]
            #   @param permissions [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted]
            #   @param project_id [String]
            #   @param service_account_id [String]
            #   @param updated_at [Integer]
            #   @param workload_identity_provider_id [String]
            #   @param object [Symbol, :"organization.workload_identity_federation_rule"]

            module AttributeMatcher
              extend OpenAI::Internal::Type::Union

              variant String

              variant OpenAI::Internal::Type::Boolean

              variant Integer

              variant Float

              # @!method self.variants
              #   @return [Array(String, Boolean, Integer, Float)]
            end

            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule#permissions
            module Permissions
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant(
                :service_account_default,
                -> {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault
                }
              )

              variant(
                :restricted,
                -> { OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted }
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
              #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted)]
            end
          end
        end
      end
    end
  end
end
