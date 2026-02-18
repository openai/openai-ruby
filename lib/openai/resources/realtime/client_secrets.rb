# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class ClientSecrets
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::ClientSecretCreateParams} for more details.
        #
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
        #
        # @overload create(expires_after: nil, session: nil, request_options: {})
        #
        # @param expires_after [OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter] Configuration for the client secret expiration. Expiration refers to the time af
        #
        # @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] Session configuration to use for the client secret. Choose either a realtime
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Realtime::ClientSecretCreateResponse]
        #
        # @see OpenAI::Models::Realtime::ClientSecretCreateParams
        def create(params = {})
          parsed, options = OpenAI::Realtime::ClientSecretCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "realtime/client_secrets",
            body: parsed,
            model: OpenAI::Models::Realtime::ClientSecretCreateResponse,
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
