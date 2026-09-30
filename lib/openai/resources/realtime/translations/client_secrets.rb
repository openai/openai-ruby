# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        class ClientSecrets
          # Create a Realtime translation client secret with an associated translation
          # session configuration.
          #
          # Client secrets are short-lived tokens that can be passed to a client app, such
          # as a web frontend or mobile client, which grants access to the Realtime
          # Translation API without leaking your main API key. You can configure a custom
          # TTL for each client secret.
          #
          # Returns the created client secret and the effective translation session object.
          # The client secret is a string that looks like `ek_1234`.
          #
          # @overload create(session:, expires_after: nil, request_options: {})
          #
          # @param session [OpenAI::Models::Realtime::RealtimeTranslationSessionCreateRequest]
          #   Realtime translation session configuration. Translation sessions stream source
          #   audio in and translated audio plus transcript deltas out continuously.
          #
          # @param expires_after [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter]
          #   Configuration for the client secret expiration. Expiration refers to the time
          #   after which a client secret will no longer be valid for creating sessions. The
          #   session itself may continue after that time once started. A secret can be used
          #   to create multiple sessions until it expires.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateResponse]
          #
          # @see OpenAI::Models::Realtime::Translations::ClientSecretCreateParams
          def create(params)
            parsed, options = OpenAI::Realtime::Translations::ClientSecretCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "realtime/translations/client_secrets",
              body: parsed,
              model: OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
