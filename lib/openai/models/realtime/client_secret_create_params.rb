# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::ClientSecrets#create
      class ClientSecretCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute expires_after
        #   Configuration for the ephemeral token expiration.
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
        #   @param expires_after [OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter] Configuration for the ephemeral token expiration.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] Session configuration to use for the client secret. Choose either a realtime
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          # @!attribute anchor
          #   The anchor point for the ephemeral token expiration. Only `created_at` is
          #   currently supported.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor, nil]
          optional :anchor, enum: -> { OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor }

          # @!attribute seconds
          #   The number of seconds from the anchor point to the expiration. Select a value
          #   between `10` and `7200`.
          #
          #   @return [Integer, nil]
          optional :seconds, Integer

          # @!method initialize(anchor: nil, seconds: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter} for more
          #   details.
          #
          #   Configuration for the ephemeral token expiration.
          #
          #   @param anchor [Symbol, OpenAI::Models::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor] The anchor point for the ephemeral token expiration. Only `created_at` is curren
          #
          #   @param seconds [Integer] The number of seconds from the anchor point to the expiration. Select a value be

          # The anchor point for the ephemeral token expiration. Only `created_at` is
          # currently supported.
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
