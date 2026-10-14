# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # Client-secret updates that preserve the credential's OAuth authentication
          # method.
          module McpOauthTokenEndpointAuthRotateParam
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Updates credentials sent using HTTP Basic authentication.
            variant(
              :client_secret_basic,
              -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic }
            )

            # Updates credentials sent in the token request body.
            variant(
              :client_secret_post,
              -> { OpenAI::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost }
            )

            class ClientSecretBasic < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `client_secret_basic`.
              #
              #   @return [Symbol, :client_secret_basic]
              required :type, const: :client_secret_basic

              # @!attribute client_secret
              #   The replacement OAuth client secret. Omit or pass `null` to keep the stored
              #   secret. This secret is never returned in resources.
              #
              #   @return [String, nil]
              optional :client_secret, String, nil?: true

              # @!method initialize(client_secret: nil, type: :client_secret_basic)
              #   Updates credentials sent using HTTP Basic authentication.
              #
              #   @param client_secret [String, nil]
              #     The replacement OAuth client secret. Omit or pass `null` to keep the stored
              #     secret. This secret is never returned in resources.
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

              # @!attribute client_secret
              #   The replacement OAuth client secret. Omit or pass `null` to keep the stored
              #   secret. This secret is never returned in resources.
              #
              #   @return [String, nil]
              optional :client_secret, String, nil?: true

              # @!method initialize(client_secret: nil, type: :client_secret_post)
              #   Updates credentials sent in the token request body.
              #
              #   @param client_secret [String, nil]
              #     The replacement OAuth client secret. Omit or pass `null` to keep the stored
              #     secret. This secret is never returned in resources.
              #
              #   @param type [Symbol, :client_secret_post]
              #     The type of the object. Always `client_secret_post`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretBasic, OpenAI::Models::Beta::Agents::Vaults::McpOauthTokenEndpointAuthRotateParam::ClientSecretPost)]
          end
        end
      end
    end
  end
end
