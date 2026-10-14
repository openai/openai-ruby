# typed: strong

module OpenAI
  module Resources
    class Realtime
      class ClientSecrets
        # Create a Realtime client secret with an associated session configuration.
        #
        # Client secrets are short-lived tokens that can be passed to a client app, such
        # as a web frontend or mobile client, which grants access to the Realtime API
        # without leaking your main API key. You can configure a custom TTL for each
        # client secret.
        #
        # You can also attach session configuration options to the client secret, which
        # will be applied to any sessions created using that client secret, but these can
        # also be overridden by the client connection.
        #
        # [Learn more about authentication with client secrets over WebRTC](https://platform.openai.com/docs/guides/realtime-webrtc).
        #
        # Returns the created client secret and the effective session object. The client
        # secret is a string that looks like `ek_1234`.
        sig do
          params(
            expires_after:
              OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::OrHash,
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Realtime::ClientSecretCreateResponse)
        end
        def create(
          # Configuration for the client secret expiration. Expiration refers to the time
          # after which a client secret will no longer be valid for creating sessions. The
          # session itself may continue after that time once started. A secret can be used
          # to create multiple sessions until it expires.
          expires_after: nil,
          # Session configuration to use for the client secret. Choose either a realtime
          # session or a transcription session.
          session: nil,
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
