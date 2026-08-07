# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationClientSecretCreateRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Realtime translation session configuration. Translation sessions stream source
        #   audio in and translated audio plus transcript deltas out continuously.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionCreateRequest]
        required :session, -> { OpenAI::Realtime::RealtimeTranslationSessionCreateRequest }

        # @!attribute expires_after
        #   Configuration for the client secret expiration. Expiration refers to the time
        #   after which a client secret will no longer be valid for creating sessions. The
        #   session itself may continue after that time once started. A secret can be used
        #   to create multiple sessions until it expires.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter, nil]
        optional :expires_after,
                 -> { OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter }

        # @!method initialize(session:, expires_after: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest} for
        #   more details.
        #
        #   Create a translation session and client secret for the Realtime API.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSessionCreateRequest] Realtime translation session configuration. Translation sessions stream source
        #
        #   @param expires_after [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter] Configuration for the client secret expiration. Expiration refers to the time af

        # @see OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest#expires_after
        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          # @!attribute anchor
          #   The anchor point for the client secret expiration, meaning that `seconds` will
          #   be added to the `created_at` time of the client secret to produce an expiration
          #   timestamp. Only `created_at` is currently supported.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor, nil]
          optional :anchor,
                   enum: -> { OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor }

          # @!attribute seconds
          #   The number of seconds from the anchor point to the expiration. Select a value
          #   between `10` and `7200` (2 hours). This default to 600 seconds (10 minutes) if
          #   not specified.
          #
          #   @return [Integer, nil]
          optional :seconds, Integer

          # @!method initialize(anchor: nil, seconds: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter}
          #   for more details.
          #
          #   Configuration for the client secret expiration. Expiration refers to the time
          #   after which a client secret will no longer be valid for creating sessions. The
          #   session itself may continue after that time once started. A secret can be used
          #   to create multiple sessions until it expires.
          #
          #   @param anchor [Symbol, OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor] The anchor point for the client secret expiration, meaning that `seconds` will b
          #
          #   @param seconds [Integer] The number of seconds from the anchor point to the expiration. Select a value be

          # The anchor point for the client secret expiration, meaning that `seconds` will
          # be added to the `created_at` time of the client secret to produce an expiration
          # timestamp. Only `created_at` is currently supported.
          #
          # @see OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter#anchor
          module Anchor
            extend OpenAI::Internal::Type::Enum

            CREATED_AT = :created_at

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
