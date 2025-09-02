# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsageInputTokenDetails < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_tokens
        #   The number of audio tokens used in the Response.
        #
        #   @return [Integer, nil]
        optional :audio_tokens, Integer

        # @!attribute cached_tokens
        #   The number of cached tokens used in the Response.
        #
        #   @return [Integer, nil]
        optional :cached_tokens, Integer

        # @!attribute text_tokens
        #   The number of text tokens used in the Response.
        #
        #   @return [Integer, nil]
        optional :text_tokens, Integer

        # @!method initialize(audio_tokens: nil, cached_tokens: nil, text_tokens: nil)
        #   Details about the input tokens used in the Response.
        #
        #   @param audio_tokens [Integer] The number of audio tokens used in the Response.
        #
        #   @param cached_tokens [Integer] The number of cached tokens used in the Response.
        #
        #   @param text_tokens [Integer] The number of text tokens used in the Response.
      end
    end
  end
end
