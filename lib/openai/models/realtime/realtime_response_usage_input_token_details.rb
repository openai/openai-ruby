# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsageInputTokenDetails < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_tokens
        #   The number of audio tokens used as input for the Response.
        #
        #   @return [Integer, nil]
        optional :audio_tokens, Integer

        # @!attribute cached_tokens
        #   The number of cached tokens used as input for the Response.
        #
        #   @return [Integer, nil]
        optional :cached_tokens, Integer

        # @!attribute cached_tokens_details
        #   Details about the cached tokens used as input for the Response.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails, nil]
        optional :cached_tokens_details,
                 -> { OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails }

        # @!attribute image_tokens
        #   The number of image tokens used as input for the Response.
        #
        #   @return [Integer, nil]
        optional :image_tokens, Integer

        # @!attribute text_tokens
        #   The number of text tokens used as input for the Response.
        #
        #   @return [Integer, nil]
        optional :text_tokens, Integer

        # @!method initialize(audio_tokens: nil, cached_tokens: nil, cached_tokens_details: nil, image_tokens: nil, text_tokens: nil)
        #   Details about the input tokens used in the Response. Cached tokens are tokens
        #   from previous turns in the conversation that are included as context for the
        #   current response. Cached tokens here are counted as a subset of input tokens,
        #   meaning input tokens will include cached and uncached tokens.
        #
        #   @param audio_tokens [Integer] The number of audio tokens used as input for the Response.
        #
        #   @param cached_tokens [Integer] The number of cached tokens used as input for the Response.
        #
        #   @param cached_tokens_details [OpenAI::Models::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails] Details about the cached tokens used as input for the Response.
        #
        #   @param image_tokens [Integer] The number of image tokens used as input for the Response.
        #
        #   @param text_tokens [Integer] The number of text tokens used as input for the Response.

        # @see OpenAI::Models::Realtime::RealtimeResponseUsageInputTokenDetails#cached_tokens_details
        class CachedTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute audio_tokens
          #   The number of cached audio tokens used as input for the Response.
          #
          #   @return [Integer, nil]
          optional :audio_tokens, Integer

          # @!attribute image_tokens
          #   The number of cached image tokens used as input for the Response.
          #
          #   @return [Integer, nil]
          optional :image_tokens, Integer

          # @!attribute text_tokens
          #   The number of cached text tokens used as input for the Response.
          #
          #   @return [Integer, nil]
          optional :text_tokens, Integer

          # @!method initialize(audio_tokens: nil, image_tokens: nil, text_tokens: nil)
          #   Details about the cached tokens used as input for the Response.
          #
          #   @param audio_tokens [Integer] The number of cached audio tokens used as input for the Response.
          #
          #   @param image_tokens [Integer] The number of cached image tokens used as input for the Response.
          #
          #   @param text_tokens [Integer] The number of cached text tokens used as input for the Response.
        end
      end
    end
  end
end
