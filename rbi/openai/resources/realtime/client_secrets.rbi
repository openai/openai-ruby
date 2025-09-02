# typed: strong

module OpenAI
  module Resources
    class Realtime
      class ClientSecrets
        # Create a Realtime session and client secret for either realtime or
        # transcription.
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
          # Configuration for the ephemeral token expiration.
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
