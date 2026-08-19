# typed: strong

module OpenAI
  module Models

    module Realtime

      # Constrains effort on reasoning for reasoning-capable Realtime models such as
      # `gpt-realtime-2`.
      module RealtimeReasoningEffort
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeReasoningEffort) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        MINIMAL = T.let(:minimal, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        LOW = T.let(:low, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        MEDIUM = T.let(:medium, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)
        XHIGH = T.let(:xhigh, OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Realtime::RealtimeReasoningEffort::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
