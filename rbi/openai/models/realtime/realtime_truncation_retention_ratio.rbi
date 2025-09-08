# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTruncationRetentionRatio < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTruncationRetentionRatio,
              OpenAI::Internal::AnyHash
            )
          end

        # Fraction of post-instruction conversation tokens to retain (0.0 - 1.0) when the
        # conversation exceeds the input token limit.
        sig { returns(Float) }
        attr_accessor :retention_ratio

        # Use retention ratio truncation.
        sig { returns(Symbol) }
        attr_accessor :type

        # Retain a fraction of the conversation tokens when the conversation exceeds the
        # input token limit. This allows you to amortize truncations across multiple
        # turns, which can help improve cached token usage.
        sig do
          params(retention_ratio: Float, type: Symbol).returns(T.attached_class)
        end
        def self.new(
          # Fraction of post-instruction conversation tokens to retain (0.0 - 1.0) when the
          # conversation exceeds the input token limit.
          retention_ratio:,
          # Use retention ratio truncation.
          type: :retention_ratio
        )
        end

        sig { override.returns({ retention_ratio: Float, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
