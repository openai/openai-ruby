# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # Client-secret updates that preserve the credential's OAuth authentication
          # method.
          module McpOauthTokenEndpointAuthRotateParam
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic,
                OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost
              )
            end

            class ClientSecretBasic < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `client_secret_basic`.
              sig { returns(Symbol) }
              attr_accessor :type

              # The replacement OAuth client secret. Omit or pass `null` to keep the stored
              # secret. This secret is never returned in resources.
              sig { returns(T.nilable(String)) }
              attr_accessor :client_secret

              # Updates credentials sent using HTTP Basic authentication.
              sig do
                params(

                  client_secret: T.nilable(String),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The replacement OAuth client secret. Omit or pass `null` to keep the stored
                # secret. This secret is never returned in resources.
                client_secret: nil,

                # The type of the object. Always `client_secret_basic`.

                type: :client_secret_basic
              )
              end

              sig do
                override.returns(
                  {type: Symbol, client_secret: T.nilable(String)}
                )
              end
              def to_hash
              end

            end

            class ClientSecretPost < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `client_secret_post`.
              sig { returns(Symbol) }
              attr_accessor :type

              # The replacement OAuth client secret. Omit or pass `null` to keep the stored
              # secret. This secret is never returned in resources.
              sig { returns(T.nilable(String)) }
              attr_accessor :client_secret

              # Updates credentials sent in the token request body.
              sig do
                params(

                  client_secret: T.nilable(String),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The replacement OAuth client secret. Omit or pass `null` to keep the stored
                # secret. This secret is never returned in resources.
                client_secret: nil,

                # The type of the object. Always `client_secret_post`.

                type: :client_secret_post
              )
              end

              sig do
                override.returns(
                  {type: Symbol, client_secret: T.nilable(String)}
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(T::Array[OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::Variants])
            }
            def self.variants
            end

          end

        end

      end

    end

  end
end
