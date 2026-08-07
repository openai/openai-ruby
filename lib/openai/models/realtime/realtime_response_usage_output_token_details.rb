# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsageOutputTokenDetails < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_tokens
        #   The number of audio tokens used in the Response.
        #
        #   @return [Integer, nil]
        optional :audio_tokens, Integer

        # @!attribute text_tokens
        #   The number of text tokens used in the Response.
        #
        #   @return [Integer, nil]
        optional :text_tokens, Integer

        # @!method initialize(audio_tokens: nil, text_tokens: nil)
        #   Details about the output tokens used in the Response.
        #
        #   @param audio_tokens [Integer] The number of audio tokens used in the Response.
        #
        #   @param text_tokens [Integer] The number of text tokens used in the Response.
      end
    end
  end
end
