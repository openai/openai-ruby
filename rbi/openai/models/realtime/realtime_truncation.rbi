# typed: strong

module OpenAI
  module Models
    module Realtime
      # Controls how the realtime conversation is truncated prior to model inference.
      # The default is `auto`. When set to `retention_ratio`, the server retains a
      # fraction of the conversation tokens prior to the instructions.
      module RealtimeTruncation
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::TaggedSymbol,
              OpenAI::Realtime::RealtimeTruncation::RetentionRatioTruncation
            )
          end

        # The truncation strategy to use for the session.
        module RealtimeTruncationStrategy
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::TaggedSymbol
            )
          DISABLED =
            T.let(
              :disabled,
              OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class RetentionRatioTruncation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTruncation::RetentionRatioTruncation,
                OpenAI::Internal::AnyHash
              )
            end

          # Fraction of pre-instruction conversation tokens to retain (0.0 - 1.0).
          sig { returns(Float) }
          attr_accessor :retention_ratio

          # Use retention ratio truncation.
          sig { returns(Symbol) }
          attr_accessor :type

          # Optional cap on tokens allowed after the instructions.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :post_instructions_token_limit

          # Retain a fraction of the conversation tokens.
          sig do
            params(
              retention_ratio: Float,
              post_instructions_token_limit: T.nilable(Integer),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Fraction of pre-instruction conversation tokens to retain (0.0 - 1.0).
            retention_ratio:,
            # Optional cap on tokens allowed after the instructions.
            post_instructions_token_limit: nil,
            # Use retention ratio truncation.
            type: :retention_ratio
          )
          end

          sig do
            override.returns(
              {
                retention_ratio: Float,
                type: Symbol,
                post_instructions_token_limit: T.nilable(Integer)
              }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeTruncation::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
