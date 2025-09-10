# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::ClientSecrets#create
      class ClientSecretCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute expires_at
        #   Expiration timestamp for the client secret, in seconds since epoch.
        #
        #   @return [Integer]
        required :expires_at, Integer

        # @!attribute session
        #   The session configuration for either a realtime or transcription session.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse]
        required :session, union: -> { OpenAI::Models::Realtime::ClientSecretCreateResponse::Session }

        # @!attribute value
        #   The generated client secret value.
        #
        #   @return [String]
        required :value, String

        # @!method initialize(expires_at:, session:, value:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ClientSecretCreateResponse} for more details.
        #
        #   Response from creating a session and client secret for the Realtime API.
        #
        #   @param expires_at [Integer] Expiration timestamp for the client secret, in seconds since epoch.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateResponse, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse] The session configuration for either a realtime or transcription session.
        #
        #   @param value [String] The generated client secret value.

        # The session configuration for either a realtime or transcription session.
        #
        # @see OpenAI::Models::Realtime::ClientSecretCreateResponse#session
        module Session
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A new Realtime session configuration, with an ephemeral key. Default TTL
          # for keys is one minute.
          variant :realtime, -> { OpenAI::Realtime::RealtimeSessionCreateResponse }

          # A Realtime transcription session configuration object.
          variant :transcription, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeSessionCreateResponse, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse)]
        end
      end
    end
  end
end
