# typed: strong

module OpenAI
  module Models
    module Realtime
      # Constrains effort on reasoning for reasoning-capable Realtime models such as
      # `gpt-realtime-2`.
      module RealtimeReasoningEffort
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::Realtime::RealtimeReasoningEffort)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        MINIMAL =
          T.let(
            :minimal,
            OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol
          )
        LOW =
          T.let(:low, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        MEDIUM =
          T.let(
            :medium,
            OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol
          )
        HIGH =
          T.let(:high, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        XHIGH =
          T.let(:xhigh, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
