# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An event emitted by a Managed Agents session.
      module AgentSessionEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when a turn or session fails.
        variant :error, -> { OpenAI::Beta::AgentSessionErrorEvent }

        # Emitted when a hosted session environment is ready to connect.
        variant :"agent.session.environment.ready", -> { OpenAI::Beta::AgentSessionEnvironmentReadyEvent }

        # Emitted when command execution produces an output delta.
        variant(
          :"agent.output.command_execution_output.delta",
          -> { OpenAI::Beta::AgentOutputCommandExecutionOutputDeltaEvent }
        )

        # Emitted when a session is created.
        variant :"agent.session.created", -> { OpenAI::Beta::AgentSessionCreatedEvent }

        # Emitted when a turn is created.
        variant :"agent.session.turn.created", -> { OpenAI::Beta::AgentSessionTurnCreatedEvent }

        # Emitted when a turn starts running.
        variant :"agent.session.turn.in_progress", -> { OpenAI::Beta::AgentSessionTurnInProgressEvent }

        # Emitted when a turn completes.
        variant :"agent.session.turn.completed", -> { OpenAI::Beta::AgentSessionTurnCompletedEvent }

        # Emitted when a turn fails.
        variant :"agent.session.turn.failed", -> { OpenAI::Beta::AgentSessionTurnFailedEvent }

        # Emitted when a turn is cancelled.
        variant :"agent.session.turn.cancelled", -> { OpenAI::Beta::AgentSessionTurnCancelledEvent }

        # Emitted when an item is added to a turn.
        variant :"agent.session.turn.item.added", -> { OpenAI::Beta::AgentSessionTurnItemAddedEvent }

        # Emitted when a session becomes idle.
        variant :"agent.session.idle", -> { OpenAI::Beta::AgentSessionIdleEvent }

        # Emitted when a session starts processing a turn.
        variant :"agent.session.in_progress", -> { OpenAI::Beta::AgentSessionInProgressEvent }

        # Emitted when a session is waiting for one or more required actions.
        variant :"agent.session.requires_action", -> { OpenAI::Beta::AgentSessionRequiresActionEvent }

        # Emitted when a session fails.
        variant :"agent.session.failed", -> { OpenAI::Beta::AgentSessionFailedEvent }

        # Emitted while a session environment is being prepared.
        variant :"agent.session.environment.pending", -> { OpenAI::Beta::AgentSessionEnvironmentPendingEvent }

        # Emitted when a session environment connects.
        variant :"agent.session.environment.connected", -> { OpenAI::Beta::AgentSessionEnvironmentConnectedEvent }

        # Emitted when a session environment disconnects.
        variant(
          :"agent.session.environment.disconnected",
          -> { OpenAI::Beta::AgentSessionEnvironmentDisconnectedEvent }
        )

        # Emitted when a session environment fails.
        variant :"agent.session.environment.failed", -> { OpenAI::Beta::AgentSessionEnvironmentFailedEvent }

        # Emitted when a subagent is created.
        variant :"agent.session.subagent.created", -> { OpenAI::Beta::AgentSessionSubagentCreatedEvent }

        # Emitted when a closed subagent successfully resumes.
        variant :"agent.session.subagent.active", -> { OpenAI::Beta::AgentSessionSubagentActiveEvent }

        # Emitted when a subagent is closed.
        variant :"agent.session.subagent.closed", -> { OpenAI::Beta::AgentSessionSubagentClosedEvent }

        # Emitted when an output item is complete.
        variant :"agent.session.turn.item.done", -> { OpenAI::Beta::AgentSessionTurnItemDoneEvent }

        # Emitted when an output text content part is added.
        variant(
          :"agent.session.turn.content_part.added",
          -> { OpenAI::Beta::AgentSessionTurnContentPartAddedEvent }
        )

        # Emitted when an output content part is complete.
        variant :"agent.session.turn.content_part.done", -> { OpenAI::Beta::AgentSessionTurnContentPartDoneEvent }

        # Emitted when text is appended to an output text content part.
        variant :"agent.session.turn.output_text.delta", -> { OpenAI::Beta::AgentSessionTurnOutputTextDeltaEvent }

        # Emitted when an output text content part is complete.
        variant :"agent.session.turn.output_text.done", -> { OpenAI::Beta::AgentSessionTurnOutputTextDoneEvent }

        # Emitted when a reasoning summary content part is added.
        variant(
          :"agent.session.turn.reasoning_summary_part.added",
          -> { OpenAI::Beta::AgentSessionTurnReasoningSummaryPartAddedEvent }
        )

        # Emitted when a reasoning summary part is complete.
        variant(
          :"agent.session.turn.reasoning_summary_part.done",
          -> { OpenAI::Beta::AgentSessionTurnReasoningSummaryPartDoneEvent }
        )

        # Emitted when text is appended to a reasoning summary.
        variant(
          :"agent.session.turn.reasoning_summary_text.delta",
          -> { OpenAI::Beta::AgentSessionTurnReasoningSummaryTextDeltaEvent }
        )

        # Emitted when a reasoning summary content part is complete.
        variant(
          :"agent.session.turn.reasoning_summary_text.done",
          -> { OpenAI::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent }
        )

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionErrorEvent, OpenAI::Models::Beta::AgentSessionEnvironmentReadyEvent, OpenAI::Models::Beta::AgentOutputCommandExecutionOutputDeltaEvent, OpenAI::Models::Beta::AgentSessionCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnInProgressEvent, OpenAI::Models::Beta::AgentSessionTurnCompletedEvent, OpenAI::Models::Beta::AgentSessionTurnFailedEvent, OpenAI::Models::Beta::AgentSessionTurnCancelledEvent, OpenAI::Models::Beta::AgentSessionTurnItemAddedEvent, OpenAI::Models::Beta::AgentSessionIdleEvent, OpenAI::Models::Beta::AgentSessionInProgressEvent, OpenAI::Models::Beta::AgentSessionRequiresActionEvent, OpenAI::Models::Beta::AgentSessionFailedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentPendingEvent, OpenAI::Models::Beta::AgentSessionEnvironmentConnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentDisconnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentFailedEvent, OpenAI::Models::Beta::AgentSessionSubagentCreatedEvent, OpenAI::Models::Beta::AgentSessionSubagentActiveEvent, OpenAI::Models::Beta::AgentSessionSubagentClosedEvent, OpenAI::Models::Beta::AgentSessionTurnItemDoneEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent)]
      end
    end
  end
end
