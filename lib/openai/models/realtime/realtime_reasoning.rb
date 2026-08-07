# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeReasoning < OpenAI::Internal::Type::BaseModel
        # @!attribute effort
        #   Constrains effort on reasoning for reasoning-capable Realtime models such as
        #   `gpt-realtime-2`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeReasoningEffort, nil]
        optional :effort, enum: -> { OpenAI::Realtime::RealtimeReasoningEffort }

        # @!method initialize(effort: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeReasoning} for more details.
        #
        #   Configuration for reasoning-capable Realtime models such as `gpt-realtime-2`.
        #
        #   @param effort [Symbol, OpenAI::Models::Realtime::RealtimeReasoningEffort] Constrains effort on reasoning for reasoning-capable Realtime models such as
      end
    end
  end
end
