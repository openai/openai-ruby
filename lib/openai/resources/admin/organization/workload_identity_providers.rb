# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class WorkloadIdentityProviders
          # @return [OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules]
          attr_reader :federation_rules

          # Register an OIDC provider for keyless project service-account authentication.
          #
          # @overload create(audience:, issuer:, name:, attribute_transformations: nil, description: nil, enabled: nil, verification: nil, type: :oidc, request_options: {})
          #
          # @param audience [String]
          # @param issuer [String]
          # @param name [String]
          # @param attribute_transformations [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation>]
          # @param description [String]
          # @param enabled [Boolean]
          # @param verification [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks]
          # @param type [Symbol, :oidc]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProvider]
          #
          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/workload_identity_providers",
              body: parsed,
              model: OpenAI::Admin::Organization::WorkloadIdentityProvider,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieve an OIDC provider in the authenticated organization.
          #
          # @overload retrieve(workload_identity_provider_id, request_options: {})
          #
          # @param workload_identity_provider_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProvider]
          #
          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviderRetrieveParams
          def retrieve(workload_identity_provider_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/workload_identity_providers/%1$s", workload_identity_provider_id],
              model: OpenAI::Admin::Organization::WorkloadIdentityProvider,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Update supplied provider fields, preserving omitted fields.
          #
          # @overload update(workload_identity_provider_id, attribute_transformations: nil, audience: nil, description: nil, enabled: nil, issuer: nil, name: nil, verification: nil, request_options: {})
          #
          # @param workload_identity_provider_id [String]
          # @param attribute_transformations [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation>]
          # @param audience [String]
          # @param description [String, nil]
          # @param enabled [Boolean]
          # @param issuer [String]
          # @param name [String]
          # @param verification [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProvider]
          #
          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams
          def update(workload_identity_provider_id, params = {})
            parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/workload_identity_providers/%1$s", workload_identity_provider_id],
              body: parsed,
              model: OpenAI::Admin::Organization::WorkloadIdentityProvider,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # List OIDC providers in the authenticated Admin API key's organization.
          #
          # @overload list(after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams::Order]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Admin::Organization::WorkloadIdentityProvider>]
          #
          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::WorkloadIdentityProviderListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/workload_identity_providers",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Admin::Organization::WorkloadIdentityProvider,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete a provider after deleting all its federation rules.
          #
          # @overload delete(workload_identity_provider_id, request_options: {})
          #
          # @param workload_identity_provider_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderDeleted]
          #
          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProviderDeleteParams
          def delete(workload_identity_provider_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/workload_identity_providers/%1$s", workload_identity_provider_id],
              model: OpenAI::Admin::Organization::WorkloadIdentityProviderDeleted,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @federation_rules = OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules.new(
              client: client
            )
          end
        end
      end
    end
  end
end
