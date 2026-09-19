# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # Updates to a vault credential without changing its authentication method or
          # destination configuration.
          module CredentialAuthRotateParam
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Rotate an OAuth credential for an HTTPS MCP destination.
            variant :mcp_oauth, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth }

            # Replace the bearer token for the credential's MCP server.
            variant :static_bearer, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer }

            # Replace the secret for an OpenAI-hosted environment credential. The environment variable name and networking configuration remain unchanged.
            variant(
              :environment_variable,
              -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable }
            )

            class McpOauth < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `mcp_oauth`.
              #
              #   @return [Symbol, :mcp_oauth]
              required :type, const: :mcp_oauth

              # @!attribute access_token
              #   A write-only replacement OAuth access token.
              #
              #   @return [String, nil]
              optional :access_token, String, nil?: true

              # @!attribute expires_at
              #   The replacement expiry as an RFC 3339 timestamp, or `null` to clear it. Omitting
              #   this field preserves the expiry unless a new access token is supplied, in which
              #   case the expiry is cleared.
              #
              #   @return [String, nil]
              optional :expires_at, String, nil?: true

              # @!attribute refresh
              #   Optional write-only refresh-token and client-secret updates.
              #
              #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh, nil]
              optional(
                :refresh,
                -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh },
                nil?: true
              )

              # @!method initialize(access_token: nil, expires_at: nil, refresh: nil, type: :mcp_oauth)
              #   Rotate an OAuth credential for an HTTPS MCP destination.
              #
              #   @param access_token [String, nil]
              #     A write-only replacement OAuth access token.
              #
              #   @param expires_at [String, nil]
              #     The replacement expiry as an RFC 3339 timestamp, or `null` to clear it. Omitting
              #     this field preserves the expiry unless a new access token is supplied, in which
              #     case the expiry is cleared.
              #
              #   @param refresh [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh, nil]
              #     Optional write-only refresh-token and client-secret updates.
              #
              #   @param type [Symbol, :mcp_oauth]
              #     The type of the object. Always `mcp_oauth`.

              # @see OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth#refresh
              class Refresh < OpenAI::Internal::Type::BaseModel
                # @!attribute refresh_token
                #   The replacement refresh token. Omit or pass `null` to keep the stored token.
                #   This secret is never returned in resources.
                #
                #   @return [String, nil]
                optional :refresh_token, String, nil?: true

                # @!attribute scope
                #   Replacement space-separated OAuth scopes for refresh requests. Omit to keep the
                #   scopes, or pass `null` to stop sending a scope parameter.
                #
                #   @return [String, nil]
                optional :scope, String, nil?: true

                # @!attribute token_endpoint_auth
                #   Client-secret updates for the existing token endpoint authentication method.
                #
                #   @return [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost, nil]
                optional(
                  :token_endpoint_auth,
                  union: -> {
                    OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam
                  },
                  nil?: true
                )

                # @!method initialize(refresh_token: nil, scope: nil, token_endpoint_auth: nil)
                #   Optional write-only refresh-token and client-secret updates.
                #
                #   @param refresh_token [String, nil]
                #     The replacement refresh token. Omit or pass `null` to keep the stored token.
                #     This secret is never returned in resources.
                #
                #   @param scope [String, nil]
                #     Replacement space-separated OAuth scopes for refresh requests. Omit to keep the
                #     scopes, or pass `null` to stop sending a scope parameter.
                #
                #   @param token_endpoint_auth [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost, nil]
                #     Client-secret updates for the existing token endpoint authentication method.
              end
            end

            class StaticBearer < OpenAI::Internal::Type::BaseModel
              # @!attribute token
              #   The replacement bearer token. This secret is never returned in credential
              #   resources.
              #
              #   @return [String]
              required :token, String

              # @!attribute type
              #   The type of the object. Always `static_bearer`.
              #
              #   @return [Symbol, :static_bearer]
              required :type, const: :static_bearer

              # @!method initialize(token:, type: :static_bearer)
              #   Replace the bearer token for the credential's MCP server.
              #
              #   @param token [String]
              #     The replacement bearer token. This secret is never returned in credential
              #     resources.
              #
              #   @param type [Symbol, :static_bearer]
              #     The type of the object. Always `static_bearer`.
            end

            class EnvironmentVariable < OpenAI::Internal::Type::BaseModel
              # @!attribute secret_value
              #   The write-only replacement secret. Never returned in credential resources or
              #   supplied directly to sandbox code. Must be nonempty and must not contain
              #   carriage returns, newlines, or NUL bytes.
              #
              #   @return [String]
              required :secret_value, String

              # @!attribute type
              #   The type of the object. Always `environment_variable`.
              #
              #   @return [Symbol, :environment_variable]
              required :type, const: :environment_variable

              # @!method initialize(secret_value:, type: :environment_variable)
              #   Replace the secret for an OpenAI-hosted environment credential. The environment
              #   variable name and networking configuration remain unchanged.
              #
              #   @param secret_value [String]
              #     The write-only replacement secret. Never returned in credential resources or
              #     supplied directly to sandbox code. Must be nonempty and must not contain
              #     carriage returns, newlines, or NUL bytes.
              #
              #   @param type [Symbol, :environment_variable]
              #     The type of the object. Always `environment_variable`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable)]
          end
        end
      end
    end
  end
end
