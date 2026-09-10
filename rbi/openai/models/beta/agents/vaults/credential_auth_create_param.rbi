# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # Authentication credentials for an MCP server used by agent tools.
          module CredentialAuthCreateParam
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth,
                OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer
              )
            end

            class McpOauth < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth,
                  OpenAI::Internal::AnyHash
                )
              end

              # A write-only OAuth access token; never returned by credential resources.
              sig { returns(String) }
              attr_accessor :access_token

              # The HTTPS MCP server URL authorized by this credential.
              sig { returns(String) }
              attr_accessor :mcp_server_url

              # The type of the object. Always `mcp_oauth`.
              sig { returns(Symbol) }
              attr_accessor :type

              # When the OAuth access token expires, as an RFC 3339 timestamp, if known.
              sig { returns(T.nilable(String)) }
              attr_accessor :expires_at

              # Configuration for refreshing the access token of an MCP OAuth credential.
              sig { returns(T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh)) }
              attr_reader :refresh

              sig {
                params(
                  refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh::OrHash)
                )
                  .void
              }
              attr_writer :refresh

              # An OAuth credential for an HTTPS MCP destination.
              sig do
                params(

                  access_token: String,

                  mcp_server_url: String,

                  expires_at: T.nilable(String),

                  refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh::OrHash),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # A write-only OAuth access token; never returned by credential resources.
                access_token:,

                # The HTTPS MCP server URL authorized by this credential.
                mcp_server_url:,

                # When the OAuth access token expires, as an RFC 3339 timestamp, if known.
                expires_at: nil,

                # Configuration for refreshing the access token of an MCP OAuth credential.
                refresh: nil,

                # The type of the object. Always `mcp_oauth`.

                type: :mcp_oauth
              )
              end

              sig do
                override.returns(
                  {
                    access_token: String,
                    mcp_server_url: String,
                    type: Symbol,
                    expires_at: T.nilable(String),
                    refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh)
                  }
                )
              end
              def to_hash
              end

              class Refresh < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::Refresh,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The OAuth client ID used when requesting a new access token.
                sig { returns(String) }
                attr_accessor :client_id

                # The refresh token to store. This secret is never returned in credential
                # resources.
                sig { returns(String) }
                attr_accessor :refresh_token

                # The HTTPS OAuth token endpoint used to exchange the refresh token for a new
                # access token.
                sig { returns(String) }
                attr_accessor :token_endpoint

                # How the OAuth client authenticates to the token endpoint.
                sig {
                  returns(
                    T.any(
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::None,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretBasic,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretPost
                    )
                  )
                }
                attr_accessor :token_endpoint_auth

                # The resource URI to send to the OAuth token endpoint during refresh, if
                # required.
                sig { returns(T.nilable(String)) }
                attr_accessor :resource

                # Space-separated OAuth scopes to request during refresh, if required.
                sig { returns(T.nilable(String)) }
                attr_accessor :scope

                # Configuration for refreshing the access token of an MCP OAuth credential.
                sig do
                  params(

                    client_id: String,

                    refresh_token: String,

                    token_endpoint: String,

                    token_endpoint_auth: T.any(
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::None::OrHash,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretBasic::OrHash,
                      OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretPost::OrHash
                    ),

                    resource: T.nilable(String),

                    scope: T.nilable(String)
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The OAuth client ID used when requesting a new access token.
                  client_id:,

                  # The refresh token to store. This secret is never returned in credential
                  # resources.
                  refresh_token:,

                  # The HTTPS OAuth token endpoint used to exchange the refresh token for a new
                  # access token.
                  token_endpoint:,

                  # How the OAuth client authenticates to the token endpoint.
                  token_endpoint_auth:,

                  # The resource URI to send to the OAuth token endpoint during refresh, if
                  # required.
                  resource: nil,

                  # Space-separated OAuth scopes to request during refresh, if required.

                  scope: nil
                )
                end

                sig do
                  override.returns(
                    {
                      client_id: String,
                      refresh_token: String,
                      token_endpoint: String,
                      token_endpoint_auth: T.any(
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::None,
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretBasic,
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthCreateParam::ClientSecretPost
                      ),
                      resource: T.nilable(String),
                      scope: T.nilable(String)
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
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer,
                  OpenAI::Internal::AnyHash
                )
              end

              # The bearer token to store. This secret is never returned in credential
              # resources.
              sig { returns(String) }
              attr_accessor :token

              # The HTTPS MCP server URL authorized by this credential.
              sig { returns(String) }
              attr_accessor :mcp_server_url

              # The type of the object. Always `static_bearer`.
              sig { returns(Symbol) }
              attr_accessor :type

              # A bearer token for an MCP server, without automatic OAuth refresh.
              sig do
                params(

                  token: String,

                  mcp_server_url: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The bearer token to store. This secret is never returned in credential
                # resources.
                token:,

                # The HTTPS MCP server URL authorized by this credential.
                mcp_server_url:,

                # The type of the object. Always `static_bearer`.

                type: :static_bearer
              )
              end

              sig do
                override.returns(
                  {token: String, mcp_server_url: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
