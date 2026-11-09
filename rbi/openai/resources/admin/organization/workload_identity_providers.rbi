# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class WorkloadIdentityProviders

          sig { returns(OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules) }
          attr_reader :federation_rules

          # Register an OIDC provider for keyless project service-account authentication.
          sig {
            params(
              audience: String,
              issuer: String,
              name: String,
              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation::OrHash
              ],
              description: String,
              enabled: T::Boolean,
              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks::OrHash
              ),
              type: Symbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::WorkloadIdentityProvider)
          }
          def create(
            audience:,
            issuer:,
            name:,
            attribute_transformations: nil,
            description: nil,
            enabled: nil,
            verification: nil,
            type: :oidc,
            request_options: {}
          )
          end

          # Retrieve an OIDC provider in the authenticated organization.
          sig {
            params(workload_identity_provider_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::WorkloadIdentityProvider
            )
          }
          def retrieve(workload_identity_provider_id, request_options: {})
          end

          # Update supplied provider fields, preserving omitted fields.
          sig {
            params(
              workload_identity_provider_id: String,
              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation::OrHash
              ],
              audience: String,
              description: T.nilable(String),
              enabled: T::Boolean,
              issuer: String,
              name: String,
              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam::OrHash
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::WorkloadIdentityProvider)
          }
          def update(
            workload_identity_provider_id,
            attribute_transformations: nil,
            audience: nil,
            description: nil,
            enabled: nil,
            issuer: nil,
            name: nil,
            verification: nil,
            request_options: {}
          )
          end

          # List OIDC providers in the authenticated Admin API key's organization.
          sig {
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::WorkloadIdentityProvider])
          }
          def list(after: nil, limit: nil, order: nil, request_options: {})
          end

          # Delete a provider after deleting all its federation rules.
          sig {
            params(workload_identity_provider_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::WorkloadIdentityProviderDeleted
            )
          }
          def delete(workload_identity_provider_id, request_options: {})
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
