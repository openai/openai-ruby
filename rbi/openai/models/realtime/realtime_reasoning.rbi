# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeReasoning < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeReasoning,
              OpenAI::Internal::AnyHash
            )
          end

        # Constrains effort on reasoning for reasoning-capable Realtime models such as
        # `gpt-realtime-2`.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeReasoningEffort::OrSymbol)
          )
        end
        attr_reader :effort

        sig do
          params(
            effort: OpenAI::Realtime::RealtimeReasoningEffort::OrSymbol
          ).void
        end
        attr_writer :effort

        # Configuration for reasoning-capable Realtime models such as `gpt-realtime-2`.
        sig do
          params(
            effort: OpenAI::Realtime::RealtimeReasoningEffort::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Constrains effort on reasoning for reasoning-capable Realtime models such as
          # `gpt-realtime-2`.
          effort: nil
        )
        end

        sig do
          override.returns(
            { effort: OpenAI::Realtime::RealtimeReasoningEffort::OrSymbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
