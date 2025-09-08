# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeSessionClientSecret < OpenAI::Internal::Type::BaseModel
        # @!attribute expires_at
        #   Timestamp for when the token expires. Currently, all tokens expire after one
        #   minute.
        #
        #   @return [Integer]
        required :expires_at, Integer

        # @!attribute value
        #   Ephemeral key usable in client environments to authenticate connections to the
        #   Realtime API. Use this in client-side environments rather than a standard API
        #   token, which should only be used server-side.
        #
        #   @return [String]
        required :value, String

        # @!method initialize(expires_at:, value:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeSessionClientSecret} for more details.
        #
        #   Ephemeral key returned by the API.
        #
        #   @param expires_at [Integer] Timestamp for when the token expires. Currently, all tokens expire
        #
        #   @param value [String] Ephemeral key usable in client environments to authenticate connections to the R
      end
    end

    RealtimeSessionClientSecret = Realtime::RealtimeSessionClientSecret
  end
end
