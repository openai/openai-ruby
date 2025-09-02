# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class ClientSecrets
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::ClientSecretCreateParams} for more details.
        #
        # Create a Realtime session and client secret for either realtime or
        # transcription.
        #
        # @overload create(expires_after: nil, session: nil, request_options: {})
        #
        # @param expires_after [OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter] Configuration for the ephemeral token expiration.
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
