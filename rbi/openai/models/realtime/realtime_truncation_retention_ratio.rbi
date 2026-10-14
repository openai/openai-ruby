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

        # Fraction of post-instruction conversation tokens to retain (`0.0` - `1.0`) when
        # the conversation exceeds the input token limit. Setting this to `0.8` means that
        # messages will be dropped until 80% of the maximum allowed tokens are used. This
        # helps reduce the frequency of truncations and improve cache rates.
        sig { returns(Float) }
        attr_accessor :retention_ratio

        # Use retention ratio truncation.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional custom token limits for this truncation strategy. If not provided, the
        # model's default token limits will be used.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits
            )
          )
        end
        attr_reader :token_limits

        sig do
          params(
            token_limits:
              OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits::OrHash
          ).void
        end
        attr_writer :token_limits

        # Retain a fraction of the conversation tokens when the conversation exceeds the
        # input token limit. This allows you to amortize truncations across multiple
        # turns, which can help improve cached token usage.
        sig do
          params(
            retention_ratio: Float,
            token_limits:
              OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Fraction of post-instruction conversation tokens to retain (`0.0` - `1.0`) when
          # the conversation exceeds the input token limit. Setting this to `0.8` means that
          # messages will be dropped until 80% of the maximum allowed tokens are used. This
          # helps reduce the frequency of truncations and improve cache rates.
          retention_ratio:,
          # Optional custom token limits for this truncation strategy. If not provided, the
          # model's default token limits will be used.
          token_limits: nil,
          # Use retention ratio truncation.
          type: :retention_ratio
        )
        end

        sig do
          override.returns(
            {
              retention_ratio: Float,
              type: Symbol,
              token_limits:
                OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits
            }
          )
        end
        def to_hash
        end

        class TokenLimits < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTruncationRetentionRatio::TokenLimits,
                OpenAI::Internal::AnyHash
              )
            end

          # Maximum tokens allowed in the conversation after instructions (which including
          # tool definitions). For example, setting this to 5,000 would mean that truncation
          # would occur when the conversation exceeds 5,000 tokens after instructions. This
          # cannot be higher than the model's context window size minus the maximum output
          # tokens.
          sig { returns(T.nilable(Integer)) }
          attr_reader :post_instructions

          sig { params(post_instructions: Integer).void }
          attr_writer :post_instructions

          # Optional custom token limits for this truncation strategy. If not provided, the
          # model's default token limits will be used.
          sig { params(post_instructions: Integer).returns(T.attached_class) }
          def self.new(
            # Maximum tokens allowed in the conversation after instructions (which including
            # tool definitions). For example, setting this to 5,000 would mean that truncation
            # would occur when the conversation exceeds 5,000 tokens after instructions. This
            # cannot be higher than the model's context window size minus the maximum output
            # tokens.
            post_instructions: nil
          )
          end

          sig { override.returns({ post_instructions: Integer }) }
          def to_hash
          end
        end
      end
    end
  end
end
