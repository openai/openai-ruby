# typed: strong

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
          sig {
            params(
              session: OpenAI::Realtime::RealtimeTranslationSessionCreateRequest::OrHash,
              expires_after: OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::OrHash,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse)
          }
          def create(
            # Realtime translation session configuration. Translation sessions stream source
            # audio in and translated audio plus transcript deltas out continuously.
            session:,
            # Configuration for the client secret expiration. Expiration refers to the time
            # after which a client secret will no longer be valid for creating sessions. The
            # session itself may continue after that time once started. A secret can be used
            # to create multiple sessions until it expires.
            expires_after: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end

      end

    end

  end
end
