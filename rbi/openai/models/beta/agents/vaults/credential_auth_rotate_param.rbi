# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # Updates to a vault credential without changing its authentication method or MCP
          # server.
          module CredentialAuthRotateParam
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth,
                OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer
              )
            end

            class McpOauth < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `mcp_oauth`.
              sig { returns(Symbol) }
              attr_accessor :type

              # A write-only replacement OAuth access token.
              sig { returns(T.nilable(String)) }
              attr_accessor :access_token

              # The replacement expiry as an RFC 3339 timestamp, or `null` to clear it. Omitting
              # this field preserves the expiry unless a new access token is supplied, in which
              # case the expiry is cleared.
              sig { returns(T.nilable(String)) }
              attr_accessor :expires_at

              # Updates to an MCP credential's existing OAuth refresh configuration.
              sig { returns(T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh)) }
              attr_reader :refresh

              sig {
                params(
                  refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh::OrHash)
                )
                  .void
              }
              attr_writer :refresh

              # Rotate an OAuth credential for an HTTPS MCP destination.
              sig do
                params(

                  access_token: T.nilable(String),

                  expires_at: T.nilable(String),

                  refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh::OrHash),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # A write-only replacement OAuth access token.
                access_token: nil,

                # The replacement expiry as an RFC 3339 timestamp, or `null` to clear it. Omitting
                # this field preserves the expiry unless a new access token is supplied, in which
                # case the expiry is cleared.
                expires_at: nil,

                # Updates to an MCP credential's existing OAuth refresh configuration.
                refresh: nil,

                # The type of the object. Always `mcp_oauth`.

                type: :mcp_oauth
              )
              end

              sig do
                override.returns(
                  {
                    type: Symbol,
                    access_token: T.nilable(String),
                    expires_at: T.nilable(String),
                    refresh: T.nilable(OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh)
                  }
                )
              end
              def to_hash
              end

              class Refresh < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::Refresh,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The replacement refresh token. Omit or pass `null` to keep the stored token.
                # This secret is never returned in resources.
                sig { returns(T.nilable(String)) }
                attr_accessor :refresh_token

                # Replacement space-separated OAuth scopes for refresh requests. Omit to keep the
                # scopes, or pass `null` to stop sending a scope parameter.
                sig { returns(T.nilable(String)) }
                attr_accessor :scope

                # Client-secret updates that preserve the credential's OAuth authentication
                # method.
                sig {
                  returns(
                    T.nilable(
                      T.any(
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic,
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost
                      )
                    )
                  )
                }
                attr_accessor :token_endpoint_auth

                # Updates to an MCP credential's existing OAuth refresh configuration.
                sig do
                  params(

                    refresh_token: T.nilable(String),

                    scope: T.nilable(String),

                    token_endpoint_auth: T.nilable(
                      T.any(
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic::OrHash,
                        OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost::OrHash
                      )
                    )
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The replacement refresh token. Omit or pass `null` to keep the stored token.
                  # This secret is never returned in resources.
                  refresh_token: nil,

                  # Replacement space-separated OAuth scopes for refresh requests. Omit to keep the
                  # scopes, or pass `null` to stop sending a scope parameter.
                  scope: nil,

                  # Client-secret updates that preserve the credential's OAuth authentication
                  # method.

                  token_endpoint_auth: nil
                )
                end

                sig do
                  override.returns(
                    {
                      refresh_token: T.nilable(String),
                      scope: T.nilable(String),
                      token_endpoint_auth: T.nilable(
                        T.any(
                          OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic,
                          OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost
                        )
                      )
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
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer,
                  OpenAI::Internal::AnyHash
                )
              end

              # The replacement bearer token. This secret is never returned in credential
              # resources.
              sig { returns(String) }
              attr_accessor :token

              # The type of the object. Always `static_bearer`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Replace the bearer token for the credential's MCP server.
              sig do
                params(

                  token: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The replacement bearer token. This secret is never returned in credential
                # resources.
                token:,

                # The type of the object. Always `static_bearer`.

                type: :static_bearer
              )
              end

              sig do
                override.returns(
                  {token: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
