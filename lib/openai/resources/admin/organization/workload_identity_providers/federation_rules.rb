# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class WorkloadIdentityProviders
          class FederationRules
            # Bind verified token attributes to an existing project service account.
            #
            # @overload create(workload_identity_provider_id, attribute_matchers:, project_id:, service_account_id:, description: nil, enabled: nil, name: nil, permissions: nil, request_options: {})
            #
            # @param workload_identity_provider_id [String]
            # @param attribute_matchers [Hash{Symbol=>String, Boolean, Integer, Float}]
            # @param project_id [String]
            # @param service_account_id [String]
            # @param description [String]
            # @param enabled [Boolean]
            # @param name [String]
            # @param permissions [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule]
            #
            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams
            def create(workload_identity_provider_id, params)
              parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams
                .dump_request(params)
              @client.request(
                method: :post,
                path: [
                  "organization/workload_identity_providers/%1$s/federation_rules",
                  workload_identity_provider_id
                ],
                body: parsed,
                model: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieve a federation rule owned by the authenticated organization and provider.
            #
            # @overload retrieve(workload_identity_federation_rule_id, workload_identity_provider_id:, request_options: {})
            #
            # @param workload_identity_federation_rule_id [String]
            # @param workload_identity_provider_id [String]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule]
            #
            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleRetrieveParams
            def retrieve(workload_identity_federation_rule_id, params)
              parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleRetrieveParams
                .dump_request(params)
              workload_identity_provider_id = parsed.delete(:workload_identity_provider_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: [
                  "organization/workload_identity_providers/%1$s/federation_rules/%2$s",
                  workload_identity_provider_id,
                  workload_identity_federation_rule_id
                ],
                model: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Update supplied matcher, permission, metadata, or enabled fields.
            #
            # @overload update(workload_identity_federation_rule_id, workload_identity_provider_id:, attribute_matchers: nil, description: nil, enabled: nil, name: nil, permissions: nil, request_options: {})
            #
            # @param workload_identity_federation_rule_id [String]
            #   Path param
            #
            # @param workload_identity_provider_id [String]
            #   Path param
            #
            # @param attribute_matchers [Hash{Symbol=>String, Boolean, Integer, Float}]
            #   Body param
            #
            # @param description [String, nil]
            #   Body param
            #
            # @param enabled [Boolean]
            #   Body param
            #
            # @param name [String, nil]
            #   Body param
            #
            # @param permissions [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam]
            #   Body param
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule]
            #
            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams
            def update(workload_identity_federation_rule_id, params)
              parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams
                .dump_request(params)
              workload_identity_provider_id = parsed.delete(:workload_identity_provider_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :post,
                path: [
                  "organization/workload_identity_providers/%1$s/federation_rules/%2$s",
                  workload_identity_provider_id,
                  workload_identity_federation_rule_id
                ],
                body: parsed,
                model: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # List the provider's federation rules to project service accounts.
            #
            # @overload list(workload_identity_provider_id, after: nil, limit: nil, order: nil, service_account_id: nil, request_options: {})
            #
            # @param workload_identity_provider_id [String]
            # @param after [String]
            # @param limit [Integer]
            # @param order [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order]
            # @param service_account_id [String]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRule>]
            #
            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams
            def list(workload_identity_provider_id, params = {})
              parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams
                .dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: [
                  "organization/workload_identity_providers/%1$s/federation_rules",
                  workload_identity_provider_id
                ],
                query: query,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Delete a federation rule to a project service account.
            #
            # @overload delete(workload_identity_federation_rule_id, workload_identity_provider_id:, request_options: {})
            #
            # @param workload_identity_federation_rule_id [String]
            # @param workload_identity_provider_id [String]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleted]
            #
            # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleteParams
            def delete(workload_identity_federation_rule_id, params)
              parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleteParams
                .dump_request(params)
              workload_identity_provider_id = parsed.delete(:workload_identity_provider_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :delete,
                path: [
                  "organization/workload_identity_providers/%1$s/federation_rules/%2$s",
                  workload_identity_provider_id,
                  workload_identity_federation_rule_id
                ],
                model: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleted,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
