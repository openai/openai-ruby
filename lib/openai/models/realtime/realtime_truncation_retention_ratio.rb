# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTruncationRetentionRatio < OpenAI::Internal::Type::BaseModel
        # @!attribute retention_ratio
        #   Fraction of post-instruction conversation tokens to retain (`0.0` - `1.0`) when
        #   the conversation exceeds the input token limit. Setting this to `0.8` means that
        #   messages will be dropped until 80% of the maximum allowed tokens are used. This
        #   helps reduce the frequency of truncations and improve cache rates.
        #
        #   @return [Float]
        required :retention_ratio, Float

        # @!attribute type
        #   Use retention ratio truncation.
        #
        #   @return [Symbol, :retention_ratio]
        required :type, const: :retention_ratio

        # @!attribute token_limits
        #   Optional custom token limits for this truncation strategy. If not provided, the
        #   model's default token limits will be used.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio::TokenLimits, nil]
        optional :token_limits, -> { OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits }

        # @!method initialize(retention_ratio:, token_limits: nil, type: :retention_ratio)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio} for more details.
        #
        #   Retain a fraction of the conversation tokens when the conversation exceeds the
        #   input token limit. This allows you to amortize truncations across multiple
        #   turns, which can help improve cached token usage.
        #
        #   @param retention_ratio [Float] Fraction of post-instruction conversation tokens to retain (`0.0` - `1.0`) when
        #
        #   @param token_limits [OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio::TokenLimits] Optional custom token limits for this truncation strategy. If not provided, the
        #
        #   @param type [Symbol, :retention_ratio] Use retention ratio truncation.

        # @see OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio#token_limits
        class TokenLimits < OpenAI::Internal::Type::BaseModel
          # @!attribute post_instructions
          #   Maximum tokens allowed in the conversation after instructions (which including
          #   tool definitions). For example, setting this to 5,000 would mean that truncation
          #   would occur when the conversation exceeds 5,000 tokens after instructions. This
          #   cannot be higher than the model's context window size minus the maximum output
          #   tokens.
          #
          #   @return [Integer, nil]
          optional :post_instructions, Integer

          # @!method initialize(post_instructions: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio::TokenLimits} for
          #   more details.
          #
          #   Optional custom token limits for this truncation strategy. If not provided, the
          #   model's default token limits will be used.
          #
          #   @param post_instructions [Integer] Maximum tokens allowed in the conversation after instructions (which including t
        end
      end
    end
  end
end
