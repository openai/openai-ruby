# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTruncationRetentionRatio < OpenAI::Internal::Type::BaseModel
        # @!attribute retention_ratio
        #   Fraction of post-instruction conversation tokens to retain (0.0 - 1.0) when the
        #   conversation exceeds the input token limit.
        #
        #   @return [Float]
        required :retention_ratio, Float

        # @!attribute type
        #   Use retention ratio truncation.
        #
        #   @return [Symbol, :retention_ratio]
        required :type, const: :retention_ratio

        # @!method initialize(retention_ratio:, type: :retention_ratio)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio} for more details.
        #
        #   Retain a fraction of the conversation tokens when the conversation exceeds the
        #   input token limit. This allows you to amortize truncations across multiple
        #   turns, which can help improve cached token usage.
        #
        #   @param retention_ratio [Float] Fraction of post-instruction conversation tokens to retain (0.0 - 1.0) when the
        #
        #   @param type [Symbol, :retention_ratio] Use retention ratio truncation.
      end
    end
  end
end
