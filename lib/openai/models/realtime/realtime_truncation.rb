# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # When the number of tokens in a conversation exceeds the model's input token
      # limit, the conversation be truncated, meaning messages (starting from the
      # oldest) will not be included in the model's context. A 32k context model with
      # 4,096 max output tokens can only include 28,224 tokens in the context before
      # truncation occurs. Clients can configure truncation behavior to truncate with a
      # lower max token limit, which is an effective way to control token usage and
      # cost. Truncation will reduce the number of cached tokens on the next turn
      # (busting the cache), since messages are dropped from the beginning of the
      # context. However, clients can also configure truncation to retain messages up to
      # a fraction of the maximum context size, which will reduce the need for future
      # truncations and thus improve the cache rate. Truncation can be disabled
      # entirely, which means the server will never truncate but would instead return an
      # error if the conversation exceeds the model's input token limit.
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
