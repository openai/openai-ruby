# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Events
            # Submits message, cancellation, or tool-result events to a managed agent session.
            # See
            # [session events](https://developers.openai.com/api/docs/guides/agents-api/sessions/events).
            #
            # @overload create(session_id, events:, idempotency_key: nil, request_options: {})
            #
            # @param session_id [String]
            #   Path param: The ID of the session.
            #
            # @param events [Array<OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputMessage, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputCancel, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputToolResult>]
            #   Body param: The input events to submit to the session.
            #
            # @param idempotency_key [String]
            #   Header param: An optional client-generated key that makes retries of submitted
            #   messages idempotent.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [nil]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::EventCreateParams
            def create(session_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::EventCreateParams.dump_request(params)
              header_params = {idempotency_key: "idempotency-key"}
              @client.request(
                method: :post,
                path: ["agents/sessions/%1$s/events", session_id],
                headers: parsed.slice(*header_params.keys).transform_keys(header_params),
                body: parsed.except(*header_params.keys),
                model: NilClass,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Streams live events for an agent session. See
            # [session events](https://developers.openai.com/api/docs/guides/agents-api/sessions/events).
            #
            # @overload stream_streaming(session_id, request_options: {})
            #
            # @param session_id [String]
            #   The ID of the session.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AgentSessionErrorEvent, OpenAI::Models::Beta::AgentSessionEnvironmentReadyEvent, OpenAI::Models::Beta::AgentOutputCommandExecutionOutputDeltaEvent, OpenAI::Models::Beta::AgentSessionCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnInProgressEvent, OpenAI::Models::Beta::AgentSessionTurnCompletedEvent, OpenAI::Models::Beta::AgentSessionTurnFailedEvent, OpenAI::Models::Beta::AgentSessionTurnCancelledEvent, OpenAI::Models::Beta::AgentSessionTurnItemAddedEvent, OpenAI::Models::Beta::AgentSessionIdleEvent, OpenAI::Models::Beta::AgentSessionInProgressEvent, OpenAI::Models::Beta::AgentSessionRequiresActionEvent, OpenAI::Models::Beta::AgentSessionFailedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentPendingEvent, OpenAI::Models::Beta::AgentSessionEnvironmentConnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentDisconnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentFailedEvent, OpenAI::Models::Beta::AgentSessionSubagentCreatedEvent, OpenAI::Models::Beta::AgentSessionSubagentActiveEvent, OpenAI::Models::Beta::AgentSessionSubagentClosedEvent, OpenAI::Models::Beta::AgentSessionTurnItemDoneEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent>]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::EventStreamParams
            def stream_streaming(session_id, params = {})
              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/events", session_id],
                headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
                stream: OpenAI::Internal::Stream,
                model: OpenAI::Beta::AgentSessionEvent,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
