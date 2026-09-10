# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # Updates to a vault credential without changing its authentication method or MCP
          # server.
          module CredentialAuthRotateParam
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Rotate an OAuth credential for an HTTPS MCP destination.
            variant :mcp_oauth, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth }

            # Replace the bearer token for the credential's MCP server.
            variant :static_bearer, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer }

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
              #   Updates to an MCP credential's existing OAuth refresh configuration.
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
              #     Updates to an MCP credential's existing OAuth refresh configuration.
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
                #   Client-secret updates that preserve the credential's OAuth authentication
                #   method.
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
                #   Updates to an MCP credential's existing OAuth refresh configuration.
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
                #     Client-secret updates that preserve the credential's OAuth authentication
                #     method.
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

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer)]
          end
        end
      end
    end
  end
end
