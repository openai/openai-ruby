# typed: strong

module OpenAI
  module Models
    module Realtime
      # Controls how the realtime conversation is truncated prior to model inference.
      # The default is `auto`.
      module RealtimeTruncation
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::TaggedSymbol,
              OpenAI::Realtime::RealtimeTruncationRetentionRatio
            )
          end

        # The truncation strategy to use for the session. `auto` is the default truncation
        # strategy. `disabled` will disable truncation and emit errors when the
        # conversation exceeds the input token limit.
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
