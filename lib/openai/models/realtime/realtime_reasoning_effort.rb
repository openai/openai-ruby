# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Constrains effort on reasoning for reasoning-capable Realtime models such as
      # `gpt-realtime-2`.
      module RealtimeReasoningEffort
        extend OpenAI::Internal::Type::Enum

        MINIMAL = :minimal
        LOW = :low
        MEDIUM = :medium
        HIGH = :high
        XHIGH = :xhigh

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
