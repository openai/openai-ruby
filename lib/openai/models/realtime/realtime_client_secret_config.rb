# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeClientSecretConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute expires_after
        #   Configuration for the ephemeral token expiration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter, nil]
        optional :expires_after, -> { OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter }

        # @!method initialize(expires_after: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeClientSecretConfig} for more details.
        #
        #   Configuration options for the generated client secret.
        #
        #   @param expires_after [OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter] Configuration for the ephemeral token expiration.

        # @see OpenAI::Models::Realtime::RealtimeClientSecretConfig#expires_after
        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          # @!attribute anchor
          #   The anchor point for the ephemeral token expiration. Only `created_at` is
          #   currently supported.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor]
          required :anchor, enum: -> { OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor }

          # @!attribute seconds
          #   The number of seconds from the anchor point to the expiration. Select a value
          #   between `10` and `7200`.
          #
          #   @return [Integer, nil]
          optional :seconds, Integer

          # @!method initialize(anchor:, seconds: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter} for more
          #   details.
          #
          #   Configuration for the ephemeral token expiration.
          #
          #   @param anchor [Symbol, OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor] The anchor point for the ephemeral token expiration. Only `created_at` is curren
          #
          #   @param seconds [Integer] The number of seconds from the anchor point to the expiration. Select a value be

          # The anchor point for the ephemeral token expiration. Only `created_at` is
          # currently supported.
          #
          # @see OpenAI::Models::Realtime::RealtimeClientSecretConfig::ExpiresAfter#anchor
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
