# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationClientSecretCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute expires_at
        #   Expiration timestamp for the client secret, in seconds since epoch.
        #
        #   @return [Integer]
        required :expires_at, Integer

        # @!attribute session
        #   A Realtime translation session. Translation sessions continuously translate
        #   input audio into the configured output language.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession]
        required :session, -> { OpenAI::Realtime::RealtimeTranslationSession }

        # @!attribute value
        #   The generated client secret value.
        #
        #   @return [String]
        required :value, String

        # @!method initialize(expires_at:, session:, value:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateResponse} for
        #   more details.
        #
        #   Response from creating a translation session and client secret for the Realtime
        #   API.
        #
        #   @param expires_at [Integer] Expiration timestamp for the client secret, in seconds since epoch.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSession] A Realtime translation session. Translation sessions continuously translate inpu
        #
        #   @param value [String] The generated client secret value.
      end
    end
  end
end
