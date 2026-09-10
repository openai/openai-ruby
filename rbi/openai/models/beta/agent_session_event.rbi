# typed: strong

module OpenAI
  module Models

    module Beta

      # An event emitted by a Managed Agents session.
      module AgentSessionEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionErrorEvent,
            OpenAI::Beta::AgentSessionEnvironmentReadyEvent,
            OpenAI::Beta::AgentOutputCommandExecutionOutputDeltaEvent,
            OpenAI::Beta::AgentSessionCreatedEvent,
            OpenAI::Beta::AgentSessionTurnCreatedEvent,
            OpenAI::Beta::AgentSessionTurnInProgressEvent,
            OpenAI::Beta::AgentSessionTurnCompletedEvent,
            OpenAI::Beta::AgentSessionTurnFailedEvent,
            OpenAI::Beta::AgentSessionTurnCancelledEvent,
            OpenAI::Beta::AgentSessionTurnItemAddedEvent,
            OpenAI::Beta::AgentSessionIdleEvent,
            OpenAI::Beta::AgentSessionInProgressEvent,
            OpenAI::Beta::AgentSessionRequiresActionEvent,
            OpenAI::Beta::AgentSessionFailedEvent,
            OpenAI::Beta::AgentSessionEnvironmentPendingEvent,
            OpenAI::Beta::AgentSessionEnvironmentConnectedEvent,
            OpenAI::Beta::AgentSessionEnvironmentDisconnectedEvent,
            OpenAI::Beta::AgentSessionEnvironmentFailedEvent,
            OpenAI::Beta::AgentSessionSubagentCreatedEvent,
            OpenAI::Beta::AgentSessionSubagentActiveEvent,
            OpenAI::Beta::AgentSessionSubagentClosedEvent,
            OpenAI::Beta::AgentSessionTurnItemDoneEvent,
            OpenAI::Beta::AgentSessionTurnContentPartAddedEvent,
            OpenAI::Beta::AgentSessionTurnContentPartDoneEvent,
            OpenAI::Beta::AgentSessionTurnOutputTextDeltaEvent,
            OpenAI::Beta::AgentSessionTurnOutputTextDoneEvent,
            OpenAI::Beta::AgentSessionTurnReasoningSummaryPartAddedEvent,
            OpenAI::Beta::AgentSessionTurnReasoningSummaryPartDoneEvent,
            OpenAI::Beta::AgentSessionTurnReasoningSummaryTextDeltaEvent,
            OpenAI::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentSessionEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
