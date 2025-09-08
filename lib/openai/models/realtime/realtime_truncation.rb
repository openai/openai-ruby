# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Controls how the realtime conversation is truncated prior to model inference.
      # The default is `auto`.
      module RealtimeTruncation
        extend OpenAI::Internal::Type::Union

        # The truncation strategy to use for the session. `auto` is the default truncation strategy. `disabled` will disable truncation and emit errors when the conversation exceeds the input token limit.
        variant enum: -> { OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy }

        # Retain a fraction of the conversation tokens when the conversation exceeds the input token limit. This allows you to amortize truncations across multiple turns, which can help improve cached token usage.
        variant -> { OpenAI::Realtime::RealtimeTruncationRetentionRatio }

        # The truncation strategy to use for the session. `auto` is the default truncation
        # strategy. `disabled` will disable truncation and emit errors when the
        # conversation exceeds the input token limit.
        module RealtimeTruncationStrategy
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @!method self.variants
        #   @return [Array(Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio)]
      end
    end
  end
end
