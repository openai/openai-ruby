# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # The client authentication method used for OAuth token refresh.
          module McpOauthTokenEndpointAuth
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None,
                OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic,
                OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost
              )
            end

            class None < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `none`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Sends the client ID without a client secret.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of the object. Always `none`.

                type: :none
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            class ClientSecretBasic < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `client_secret_basic`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Sends the client ID and secret using HTTP Basic authentication.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of the object. Always `client_secret_basic`.

                type: :client_secret_basic
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            class ClientSecretPost < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `client_secret_post`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Sends the client ID and secret in the token request body.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of the object. Always `client_secret_post`.

                type: :client_secret_post
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
