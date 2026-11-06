# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class WorkloadIdentityProviders

          class FederationRules

            # Bind verified token attributes to an existing project service account.
            sig {
              params(
                workload_identity_provider_id: String,
                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher::Variants
                ],
                project_id: String,
                service_account_id: String,
                description: String,
                enabled: T::Boolean,
                name: String,
                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted::OrHash
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule)
            }
            def create(
              workload_identity_provider_id,
              attribute_matchers:,
              project_id:,
              service_account_id:,
              description: nil,
              enabled: nil,
              name: nil,
              permissions: nil,
              request_options: {}
            )
            end

            # Retrieve a federation rule owned by the authenticated organization and provider.
            sig {
              params(
                workload_identity_federation_rule_id: String,
                workload_identity_provider_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule)
            }
            def retrieve(workload_identity_federation_rule_id, workload_identity_provider_id:, request_options: {})
            end

            # Update supplied matcher, permission, metadata, or enabled fields.
            sig {
              params(
                workload_identity_federation_rule_id: String,
                workload_identity_provider_id: String,
                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
                ],
                description: T.nilable(String),
                enabled: T::Boolean,
                name: T.nilable(String),
                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam::OrHash
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule)
            }
            def update(
              # Path param
              workload_identity_federation_rule_id,
              # Path param
              workload_identity_provider_id:,
              # Body param
              attribute_matchers: nil,
              # Body param
              description: nil,
              # Body param
              enabled: nil,
              # Body param
              name: nil,
              # Body param
              permissions: nil,
              request_options: {}
            )
            end

            # List the provider's federation rules to project service accounts.
            sig {
              params(
                workload_identity_provider_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::OrSymbol,
                service_account_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(
                  OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule]
                )
            }
            def list(
              workload_identity_provider_id,
              after: nil,
              limit: nil,
              order: nil,
              service_account_id: nil,
              request_options: {}
            )
            end

            # Delete a federation rule to a project service account.
            sig {
              params(
                workload_identity_federation_rule_id: String,
                workload_identity_provider_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleted)
            }
            def delete(workload_identity_federation_rule_id, workload_identity_provider_id:, request_options: {})
            end

            # @api private
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end

        end

      end

    end

  end
end
