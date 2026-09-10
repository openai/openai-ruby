# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # Authentication credentials for an MCP server used by agent tools.
          module CredentialAuthCreateParam
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # An OAuth credential for an HTTPS MCP destination.
            variant :mcp_oauth, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth }

            # A bearer token for an MCP server, without automatic OAuth refresh.
            variant :static_bearer, -> { OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer }

            class McpOauth < OpenAI::Internal::Type::BaseModel
              # @!attribute access_token
              #   A write-only OAuth access token; never returned by credential resources.
              #
              #   @return [String]
              required :access_token, String

              # @!attribute mcp_server_url
              #   The HTTPS MCP server URL authorized by this credential.
              #
              #   @return [String]
              required :mcp_server_url, String

              # @!attribute type
              #   The type of the object. Always `mcp_oauth`.
              #
              #   @return [Symbol, :mcp_oauth]
              required :type, const: :mcp_oauth

              # @!attribute expires_at
              #   When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              #
              #   @return [String, nil]
              optional :expires_at, String, nil?: true

              # @!attribute refresh
              #   Configuration for refreshing the access token of an MCP OAuth credential.
              #
              #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh, nil]
              optional(
                :refresh,
                -> { OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh },
                nil?: true
              )

              # @!method initialize(access_token:, mcp_server_url:, expires_at: nil, refresh: nil, type: :mcp_oauth)
              #   An OAuth credential for an HTTPS MCP destination.
              #
              #   @param access_token [String]
              #     A write-only OAuth access token; never returned by credential resources.
              #
              #   @param mcp_server_url [String]
              #     The HTTPS MCP server URL authorized by this credential.
              #
              #   @param expires_at [String, nil]
              #     When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              #
              #   @param refresh [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh, nil]
              #     Configuration for refreshing the access token of an MCP OAuth credential.
              #
              #   @param type [Symbol, :mcp_oauth]
              #     The type of the object. Always `mcp_oauth`.

              # @see OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth#refresh
              class Refresh < OpenAI::Internal::Type::BaseModel
                # @!attribute client_id
                #   The OAuth client ID used when requesting a new access token.
                #
                #   @return [String]
                required :client_id, String

                # @!attribute refresh_token
                #   The refresh token to store. This secret is never returned in credential
                #   resources.
                #
                #   @return [String]
                required :refresh_token, String

                # @!attribute token_endpoint
                #   The HTTPS OAuth token endpoint used to exchange the refresh token for a new
                #   access token.
                #
                #   @return [String]
                required :token_endpoint, String

                # @!attribute token_endpoint_auth
                #   How the OAuth client authenticates to the token endpoint.
                #
                #   @return [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::None, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretPost]
                required(
                  :token_endpoint_auth,
                  union: -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam }
                )

                # @!attribute resource
                #   The resource URI to send to the OAuth token endpoint during refresh, if
                #   required.
                #
                #   @return [String, nil]
                optional :resource, String, nil?: true

                # @!attribute scope
                #   Space-separated OAuth scopes to request during refresh, if required.
                #
                #   @return [String, nil]
                optional :scope, String, nil?: true

                # @!method initialize(client_id:, refresh_token:, token_endpoint:, token_endpoint_auth:, resource: nil, scope: nil)
                #   Configuration for refreshing the access token of an MCP OAuth credential.
                #
                #   @param client_id [String]
                #     The OAuth client ID used when requesting a new access token.
                #
                #   @param refresh_token [String]
                #     The refresh token to store. This secret is never returned in credential
                #     resources.
                #
                #   @param token_endpoint [String]
                #     The HTTPS OAuth token endpoint used to exchange the refresh token for a new
                #     access token.
                #
                #   @param token_endpoint_auth [OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::None, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretPost]
                #     How the OAuth client authenticates to the token endpoint.
                #
                #   @param resource [String, nil]
                #     The resource URI to send to the OAuth token endpoint during refresh, if
                #     required.
                #
                #   @param scope [String, nil]
                #     Space-separated OAuth scopes to request during refresh, if required.
              end
            end

            class StaticBearer < OpenAI::Internal::Type::BaseModel
              # @!attribute token
              #   The bearer token to store. This secret is never returned in credential
              #   resources.
              #
              #   @return [String]
              required :token, String

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

              # @!method initialize(token:, mcp_server_url:, type: :static_bearer)
              #   A bearer token for an MCP server, without automatic OAuth refresh.
              #
              #   @param token [String]
              #     The bearer token to store. This secret is never returned in credential
              #     resources.
              #
              #   @param mcp_server_url [String]
              #     The HTTPS MCP server URL authorized by this credential.
              #
              #   @param type [Symbol, :static_bearer]
              #     The type of the object. Always `static_bearer`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer)]
          end
        end
      end
    end
  end
end
