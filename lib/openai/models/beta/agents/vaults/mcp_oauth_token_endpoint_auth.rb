# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # The client authentication method used for OAuth token refresh.
          module McpOauthTokenEndpointAuth
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Sends the client ID without a client secret.
            variant :none, -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None }

            # Sends the client ID and secret using HTTP Basic authentication.
            variant(
              :client_secret_basic,
              -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic }
            )

            # Sends the client ID and secret in the token request body.
            variant(
              :client_secret_post,
              -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost }
            )

            class None < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `none`.
              #
              #   @return [Symbol, :none]
              required :type, const: :none

              # @!method initialize(type: :none)
              #   Sends the client ID without a client secret.
              #
              #   @param type [Symbol, :none]
              #     The type of the object. Always `none`.
            end

            class ClientSecretBasic < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `client_secret_basic`.
              #
              #   @return [Symbol, :client_secret_basic]
              required :type, const: :client_secret_basic

              # @!method initialize(type: :client_secret_basic)
              #   Sends the client ID and secret using HTTP Basic authentication.
              #
              #   @param type [Symbol, :client_secret_basic]
              #     The type of the object. Always `client_secret_basic`.
            end

            class ClientSecretPost < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `client_secret_post`.
              #
              #   @return [Symbol, :client_secret_post]
              required :type, const: :client_secret_post

              # @!method initialize(type: :client_secret_post)
              #   Sends the client ID and secret in the token request body.
              #
              #   @param type [Symbol, :client_secret_post]
              #     The type of the object. Always `client_secret_post`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::None, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuth::ClientSecretPost)]
          end
        end
      end
    end
  end
end
