# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # The MCP server and authentication configuration of a vault credential, excluding
          # secrets.
          module CredentialAuth
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth,
                OpenAI::Beta::Agents::Vaults::CredentialAuth::StaticBearer
              )
            end

            class McpOauth < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth,
                  OpenAI::Internal::AnyHash
                )
              end

              # When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              sig { returns(T.nilable(String)) }
              attr_accessor :expires_at

              # The HTTPS MCP server URL authorized by this credential.
              sig { returns(String) }
              attr_accessor :mcp_server_url

              # Configuration used to refresh an MCP OAuth access token, excluding secret
              # values.
              sig { returns(T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh)) }
              attr_reader :refresh

              sig {
                params(refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh::OrHash)).void
              }
              attr_writer :refresh

              # The type of the object. Always `mcp_oauth`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Public metadata for an OAuth credential; tokens and client secrets are never
              # returned.
              sig do
                params(

                  expires_at: T.nilable(String),

                  mcp_server_url: String,

                  refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh::OrHash),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # When the OAuth access token expires, as an RFC 3339 timestamp, if known.
                expires_at:,

                # The HTTPS MCP server URL authorized by this credential.
                mcp_server_url:,

                # Configuration used to refresh an MCP OAuth access token, excluding secret
                # values.
                refresh:,

                # The type of the object. Always `mcp_oauth`.

                type: :mcp_oauth
              )
              end

              sig do
                override.returns(
                  {
                    expires_at: T.nilable(String),
                    mcp_server_url: String,
                    refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh),
                    type: Symbol
                  }
                )
              end
              def to_hash
              end

              class Refresh < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::Refresh,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The OAuth client ID used when requesting a new access token.
                sig { returns(String) }
                attr_accessor :client_id

                # The resource URI sent to the OAuth token endpoint during refresh, if configured.
                sig { returns(T.nilable(String)) }
                attr_accessor :resource

                # Space-separated OAuth scopes requested during refresh, if configured.
                sig { returns(T.nilable(String)) }
                attr_accessor :scope

                # The HTTPS OAuth token endpoint used for refresh.
                sig { returns(String) }
                attr_accessor :token_endpoint

                # How the OAuth client authenticates to the token endpoint, excluding its client
                # secret.
                sig { returns(OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::Variants) }
                attr_accessor :token_endpoint_auth

                # Configuration used to refresh an MCP OAuth access token, excluding secret
                # values.
                sig do
                  params(

                    client_id: String,

                    resource: T.nilable(String),

                    scope: T.nilable(String),

                    token_endpoint: String,

                    token_endpoint_auth: T.any(
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None::OrHash,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic::OrHash,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost::OrHash
                    )
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The OAuth client ID used when requesting a new access token.
                  client_id:,

                  # The resource URI sent to the OAuth token endpoint during refresh, if configured.
                  resource:,

                  # Space-separated OAuth scopes requested during refresh, if configured.
                  scope:,

                  # The HTTPS OAuth token endpoint used for refresh.
                  token_endpoint:,

                  # How the OAuth client authenticates to the token endpoint, excluding its client
                  # secret.

                  token_endpoint_auth:
                )
                end

                sig do
                  override.returns(
                    {
                      client_id: String,
                      resource: T.nilable(String),
                      scope: T.nilable(String),
                      token_endpoint: String,
                      token_endpoint_auth: OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::Variants
                    }
                  )
                end
                def to_hash
                end

              end
            end

            class StaticBearer < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuth::StaticBearer,
                  OpenAI::Internal::AnyHash
                )
              end

              # The HTTPS MCP server URL authorized by this credential.
              sig { returns(String) }
              attr_accessor :mcp_server_url

              # The type of the object. Always `static_bearer`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Metadata for a bearer-token credential, without automatic OAuth refresh.
              sig do
                params(

                  mcp_server_url: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The HTTPS MCP server URL authorized by this credential.
                mcp_server_url:,

                # The type of the object. Always `static_bearer`.

                type: :static_bearer
              )
              end

              sig do
                override.returns(
                  {mcp_server_url: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Vaults::CredentialAuth::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
