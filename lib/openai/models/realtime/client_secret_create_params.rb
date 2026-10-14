# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::ClientSecrets#create
      class ClientSecretCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute expires_after
        #   Configuration for the client secret expiration. Expiration refers to the time
        #   after which a client secret will no longer be valid for creating sessions. The
        #   session itself may continue after that time once started. A secret can be used
        #   to create multiple sessions until it expires.
        #
        #   @return [OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter, nil]
        optional :expires_after, -> { OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter }

        # @!attribute session
        #   Session configuration to use for the client secret. Choose either a realtime
        #   session or a transcription session.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest, nil]
        optional :session, union: -> { OpenAI::Realtime::ClientSecretCreateParams::Session }

        # @!method initialize(expires_after: nil, session: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ClientSecretCreateParams} for more details.
        #
        #   @param expires_after [OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter] Configuration for the client secret expiration. Expiration refers to the time af
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] Session configuration to use for the client secret. Choose either a realtime
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          # @!attribute anchor
          #   The anchor point for the client secret expiration, meaning that `seconds` will
          #   be added to the `created_at` time of the client secret to produce an expiration
          #   timestamp. Only `created_at` is currently supported.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor, nil]
          optional :anchor, enum: -> { OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor }

          # @!attribute seconds
          #   The number of seconds from the anchor point to the expiration. Select a value
          #   between `10` and `7200` (2 hours). This default to 600 seconds (10 minutes) if
          #   not specified.
          #
          #   @return [Integer, nil]
          optional :seconds, Integer

          # @!method initialize(anchor: nil, seconds: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter} for more
          #   details.
          #
          #   Configuration for the client secret expiration. Expiration refers to the time
          #   after which a client secret will no longer be valid for creating sessions. The
          #   session itself may continue after that time once started. A secret can be used
          #   to create multiple sessions until it expires.
          #
          #   @param anchor [Symbol, OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor] The anchor point for the client secret expiration, meaning that `seconds` will b
          #
          #   @param seconds [Integer] The number of seconds from the anchor point to the expiration. Select a value be

          # The anchor point for the client secret expiration, meaning that `seconds` will
          # be added to the `created_at` time of the client secret to produce an expiration
          # timestamp. Only `created_at` is currently supported.
          #
          # @see OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter#anchor
          module Anchor
            extend OpenAI::Internal::Type::Enum

            CREATED_AT = :created_at

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Session configuration to use for the client secret. Choose either a realtime
        # session or a transcription session.
        module Session
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Realtime session object configuration.
          variant :realtime, -> { OpenAI::Realtime::RealtimeSessionCreateRequest }

          # Realtime transcription session object configuration.
          variant :transcription, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest)]
        end
      end
    end
  end
end
