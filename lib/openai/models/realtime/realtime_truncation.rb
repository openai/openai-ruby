# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Controls how the realtime conversation is truncated prior to model inference.
      # The default is `auto`. When set to `retention_ratio`, the server retains a
      # fraction of the conversation tokens prior to the instructions.
      module RealtimeTruncation
        extend OpenAI::Internal::Type::Union

        # The truncation strategy to use for the session.
        variant enum: -> { OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy }

        # Retain a fraction of the conversation tokens.
        variant -> { OpenAI::Realtime::RealtimeTruncation::RetentionRatioTruncation }

        # The truncation strategy to use for the session.
        module RealtimeTruncationStrategy
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        class RetentionRatioTruncation < OpenAI::Internal::Type::BaseModel
          # @!attribute retention_ratio
          #   Fraction of pre-instruction conversation tokens to retain (0.0 - 1.0).
          #
          #   @return [Float]
          required :retention_ratio, Float

          # @!attribute type
          #   Use retention ratio truncation.
          #
          #   @return [Symbol, :retention_ratio]
          required :type, const: :retention_ratio

          # @!attribute post_instructions_token_limit
          #   Optional cap on tokens allowed after the instructions.
          #
          #   @return [Integer, nil]
          optional :post_instructions_token_limit, Integer, nil?: true

          # @!method initialize(retention_ratio:, post_instructions_token_limit: nil, type: :retention_ratio)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTruncation::RetentionRatioTruncation} for
          #   more details.
          #
          #   Retain a fraction of the conversation tokens.
          #
          #   @param retention_ratio [Float] Fraction of pre-instruction conversation tokens to retain (0.0 - 1.0).
          #
          #   @param post_instructions_token_limit [Integer, nil] Optional cap on tokens allowed after the instructions.
          #
          #   @param type [Symbol, :retention_ratio] Use retention ratio truncation.
        end

        # @!method self.variants
        #   @return [Array(Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncation::RetentionRatioTruncation)]
      end
    end
  end
end
