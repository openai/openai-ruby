# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # The authentication configuration of a vault credential, excluding secrets.
          module CredentialAuth
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Public metadata for an OAuth credential; tokens and client secrets are never returned.
            variant :mcp_oauth, -> { OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth }

            # Metadata for a bearer-token credential, without automatic OAuth refresh.
            variant :static_bearer, -> { OpenAI::Beta::Agents::Vaults::CredentialAuth::StaticBearer }

            # Metadata for an HTTP credential used only in OpenAI-hosted environments. Sandbox code receives a placeholder. The proxy substitutes the secret for allowed HTTPS destinations on ports 443 and 8443. The real secret is not available to sandbox code for local computation and is never returned in this resource.
            variant :environment_variable, -> { OpenAI::Beta::Agents::Vaults::CredentialAuth::EnvironmentVariable }

            class McpOauth < OpenAI::Internal::Type::BaseModel
              # @!attribute expires_at
              #   When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              #
              #   @return [String, nil]
              required :expires_at, String, nil?: true

              # @!attribute mcp_server_url
              #   The HTTPS MCP server URL authorized by this credential.
              #
              #   @return [String]
              required :mcp_server_url, String

              # @!attribute refresh
              #   Public refresh metadata without refresh tokens or OAuth client secrets.
              #
              #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh, nil]
              required(
                :refresh,
                -> {
                  OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh
                },
                nil?: true
              )

              # @!attribute type
              #   The type of the object. Always `mcp_oauth`.
              #
              #   @return [Symbol, :mcp_oauth]
              required :type, const: :mcp_oauth

              # @!method initialize(expires_at:, mcp_server_url:, refresh:, type: :mcp_oauth)
              #   Public metadata for an OAuth credential; tokens and client secrets are never
              #   returned.
              #
              #   @param expires_at [String, nil]
              #     When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              #
              #   @param mcp_server_url [String]
              #     The HTTPS MCP server URL authorized by this credential.
              #
              #   @param refresh [OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh, nil]
              #     Public refresh metadata without refresh tokens or OAuth client secrets.
              #
              #   @param type [Symbol, :mcp_oauth]
              #     The type of the object. Always `mcp_oauth`.

              # @see OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth#refresh
              class Refresh < OpenAI::Internal::Type::BaseModel
                # @!attribute client_id
                #   The OAuth client ID used when requesting a new access token.
                #
                #   @return [String]
                required :client_id, String

                # @!attribute resource
                #   The resource URI sent to the OAuth token endpoint during refresh, if configured.
                #
                #   @return [String, nil]
                required :resource, String, nil?: true

                # @!attribute scope
                #   Space-separated OAuth scopes requested during refresh, if configured.
                #
                #   @return [String, nil]
                required :scope, String, nil?: true

                # @!attribute token_endpoint
                #   The HTTPS OAuth token endpoint used for refresh.
                #
                #   @return [String]
                required :token_endpoint, String

                # @!attribute token_endpoint_auth
                #   How the OAuth client authenticates to the token endpoint, excluding its client
                #   secret.
                #
                #   @return [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost]
                required :token_endpoint_auth, union: -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth }

                # @!method initialize(client_id:, resource:, scope:, token_endpoint:, token_endpoint_auth:)
                #   Public refresh metadata without refresh tokens or OAuth client secrets.
                #
                #   @param client_id [String]
                #     The OAuth client ID used when requesting a new access token.
                #
                #   @param resource [String, nil]
                #     The resource URI sent to the OAuth token endpoint during refresh, if configured.
                #
                #   @param scope [String, nil]
                #     Space-separated OAuth scopes requested during refresh, if configured.
                #
                #   @param token_endpoint [String]
                #     The HTTPS OAuth token endpoint used for refresh.
                #
                #   @param token_endpoint_auth [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost]
                #     How the OAuth client authenticates to the token endpoint, excluding its client
                #     secret.
              end
            end

            class StaticBearer < OpenAI::Internal::Type::BaseModel
              # @!attribute mcp_server_url
              #   The HTTPS MCP server URL authorized by this credential.
              #
              #   @return [String]
              required :mcp_server_url, String

              # @!attribute type
              #   The type of the object. Always `static_bearer`.
              #
              #   @return [Symbol, :static_bearer]
              required :type, const: :static_bearer

              # @!method initialize(mcp_server_url:, type: :static_bearer)
              #   Metadata for a bearer-token credential, without automatic OAuth refresh.
              #
              #   @param mcp_server_url [String]
              #     The HTTPS MCP server URL authorized by this credential.
              #
              #   @param type [Symbol, :static_bearer]
              #     The type of the object. Always `static_bearer`.
            end

            class EnvironmentVariable < OpenAI::Internal::Type::BaseModel
              # @!attribute networking
              #   The destinations where the proxy can substitute the secret, subject to the
              #   environment network policy.
              #
              #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialNetworking::Unrestricted, OpenAI::Models::Beta::Agents::Vaults::CredentialNetworking::Limited]
              required :networking, union: -> { OpenAI::Beta::Agents::Vaults::CredentialNetworking }

              # @!attribute secret_name
              #   The environment variable name that receives the placeholder in the sandbox.
              #
              #   @return [String]
              required :secret_name, String

              # @!attribute type
              #   The type of the object. Always `environment_variable`.
              #
              #   @return [Symbol, :environment_variable]
              required :type, const: :environment_variable

              # @!method initialize(networking:, secret_name:, type: :environment_variable)
              #   Metadata for an HTTP credential used only in OpenAI-hosted environments. Sandbox
              #   code receives a placeholder. The proxy substitutes the secret for allowed HTTPS
              #   destinations on ports 443 and 8443. The real secret is not available to sandbox
              #   code for local computation and is never returned in this resource.
              #
              #   @param networking [OpenAI::Models::Beta::Agents::Vaults::CredentialNetworking::Unrestricted, OpenAI::Models::Beta::Agents::Vaults::CredentialNetworking::Limited]
              #     The destinations where the proxy can substitute the secret, subject to the
              #     environment network policy.
              #
              #   @param secret_name [String]
              #     The environment variable name that receives the placeholder in the sandbox.
              #
              #   @param type [Symbol, :environment_variable]
              #     The type of the object. Always `environment_variable`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::EnvironmentVariable)]
          end
        end
      end
    end
  end
end
