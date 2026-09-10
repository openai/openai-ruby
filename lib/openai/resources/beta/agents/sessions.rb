# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          # @return [OpenAI::Resources::Beta::Agents::Sessions::Subagents]
          attr_reader :subagents

          # @return [OpenAI::Resources::Beta::Agents::Sessions::Artifacts]
          attr_reader :artifacts

          # @return [OpenAI::Resources::Beta::Agents::Sessions::Items]
          attr_reader :items

          # @return [OpenAI::Resources::Beta::Agents::Sessions::Events]
          attr_reader :events

          # @return [OpenAI::Resources::Beta::Agents::Sessions::Turns]
          attr_reader :turns

          # See {OpenAI::Resources::Beta::Agents::Sessions#create_streaming} for streaming
          # counterpart.
          #
          # Creates a managed agent session, optionally submits initial input, and returns
          # the session or streams its events when stream is true. See
          # [running sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions).
          #
          # @overload create(environment:, agent: nil, agent_id: nil, input: nil, metadata: nil, vault_ids: nil, request_options: {})
          #
          # @param environment [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
          #   An inline execution environment or a reference to an environment template.
          #
          # @param agent [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent]
          #   Agent configuration. With `agent_id`, supplied fields override the saved agent
          #   for this session. Without `agent_id`, `model` is required.
          #
          # @param agent_id [String]
          #   The ID of a saved reusable agent. Omit `agent` to use its configuration
          #   unchanged.
          #
          # @param input [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>, nil]
          #   Initial input submitted when creating a session.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters. Omission or null defaults to an empty map.
          #
          # @param vault_ids [Array<String>, nil]
          #   The IDs of vaults made available to the session.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::AgentSession]
          #
          # @see OpenAI::Models::Beta::Agents::SessionCreateParams
          def create(params)
            parsed, options = OpenAI::Beta::Agents::SessionCreateParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#create_streaming` for the streaming use case."
              raise ArgumentError.new(message)
            end

            @client.request(
              method: :post,
              path: "agents/sessions",
              body: parsed,
              model: OpenAI::Beta::AgentSession,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # See {OpenAI::Resources::Beta::Agents::Sessions#create} for non-streaming
          # counterpart.
          #
          # Creates a managed agent session, optionally submits initial input, and returns
          # the session or streams its events when stream is true. See
          # [running sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions).
          #
          # @overload create_streaming(environment:, agent: nil, agent_id: nil, input: nil, metadata: nil, vault_ids: nil, request_options: {})
          #
          # @param environment [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
          #   An inline execution environment or a reference to an environment template.
          #
          # @param agent [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent]
          #   Agent configuration. With `agent_id`, supplied fields override the saved agent
          #   for this session. Without `agent_id`, `model` is required.
          #
          # @param agent_id [String]
          #   The ID of a saved reusable agent. Omit `agent` to use its configuration
          #   unchanged.
          #
          # @param input [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>, nil]
          #   Initial input submitted when creating a session.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters. Omission or null defaults to an empty map.
          #
          # @param vault_ids [Array<String>, nil]
          #   The IDs of vaults made available to the session.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AgentSessionErrorEvent, OpenAI::Models::Beta::AgentSessionEnvironmentReadyEvent, OpenAI::Models::Beta::AgentOutputCommandExecutionOutputDeltaEvent, OpenAI::Models::Beta::AgentSessionCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnCreatedEvent, OpenAI::Models::Beta::AgentSessionTurnInProgressEvent, OpenAI::Models::Beta::AgentSessionTurnCompletedEvent, OpenAI::Models::Beta::AgentSessionTurnFailedEvent, OpenAI::Models::Beta::AgentSessionTurnCancelledEvent, OpenAI::Models::Beta::AgentSessionTurnItemAddedEvent, OpenAI::Models::Beta::AgentSessionIdleEvent, OpenAI::Models::Beta::AgentSessionInProgressEvent, OpenAI::Models::Beta::AgentSessionRequiresActionEvent, OpenAI::Models::Beta::AgentSessionFailedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentPendingEvent, OpenAI::Models::Beta::AgentSessionEnvironmentConnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentDisconnectedEvent, OpenAI::Models::Beta::AgentSessionEnvironmentFailedEvent, OpenAI::Models::Beta::AgentSessionSubagentCreatedEvent, OpenAI::Models::Beta::AgentSessionSubagentActiveEvent, OpenAI::Models::Beta::AgentSessionSubagentClosedEvent, OpenAI::Models::Beta::AgentSessionTurnItemDoneEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnContentPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnOutputTextDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent>]
          #
          # @see OpenAI::Models::Beta::Agents::SessionCreateParams
          def create_streaming(params)
            parsed, options = OpenAI::Beta::Agents::SessionCreateParams.dump_request(params)
            unless parsed.fetch(:stream, true)
              message = "Please use `#create` for the non-streaming use case."
              raise ArgumentError.new(message)
            end

            parsed.store(:stream, true)
            @client.request(
              method: :post,
              path: "agents/sessions",
              headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
              body: parsed,
              stream: OpenAI::Internal::Stream,
              model: OpenAI::Beta::AgentSessionEvent,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # Retrieves the current state of a managed agent session. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          #
          # @overload retrieve(session_id, request_options: {})
          #
          # @param session_id [String]
          #   The ID of the session.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::AgentSession]
          #
          # @see OpenAI::Models::Beta::Agents::SessionRetrieveParams
          def retrieve(session_id, params = {})
            @client.request(
              method: :get,
              path: ["agents/sessions/%1$s", session_id],
              model: OpenAI::Beta::AgentSession,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
            )
          end

          # Updates session metadata. Omitted fields are unchanged. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          #
          # @overload update(session_id, metadata: nil, request_options: {})
          #
          # @param session_id [String]
          #   The ID of the session.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::AgentSession]
          #
          # @see OpenAI::Models::Beta::Agents::SessionUpdateParams
          def update(session_id, params = {})
            parsed, options = OpenAI::Beta::Agents::SessionUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["agents/sessions/%1$s", session_id],
              body: parsed,
              model: OpenAI::Beta::AgentSession,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # Lists managed agent sessions using ID-based pagination and the requested sort
          # order. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          #
          # @overload list(after: nil, agent_id: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String]
          #   Return resources after this resource ID in the selected order.
          #
          # @param agent_id [String]
          #   Only return sessions whose root agent has this ID. Omit to return sessions for
          #   all agents.
          #
          # @param limit [Integer, nil]
          #   The maximum number of resources to return.
          #
          # @param order [Symbol, OpenAI::Models::Beta::Agents::SessionListParams::Order]
          #   Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `desc`.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::AgentSession>]
          #
          # @see OpenAI::Models::Beta::Agents::SessionListParams
          def list(params = {})
            parsed, options = OpenAI::Beta::Agents::SessionListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "agents/sessions",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::AgentSession,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # Removes a managed agent session from the public API and returns a deletion
          # confirmation. Physical cleanup may continue asynchronously. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          #
          # @overload delete(session_id, request_options: {})
          #
          # @param session_id [String]
          #   The ID of the session.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::AgentSessionDeleted]
          #
          # @see OpenAI::Models::Beta::Agents::SessionDeleteParams
          def delete(session_id, params = {})
            @client.request(
              method: :delete,
              path: ["agents/sessions/%1$s", session_id],
              model: OpenAI::Beta::AgentSessionDeleted,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @subagents = OpenAI::Resources::Beta::Agents::Sessions::Subagents.new(client: client)
            @artifacts = OpenAI::Resources::Beta::Agents::Sessions::Artifacts.new(client: client)
            @items = OpenAI::Resources::Beta::Agents::Sessions::Items.new(client: client)
            @events = OpenAI::Resources::Beta::Agents::Sessions::Events.new(client: client)
            @turns = OpenAI::Resources::Beta::Agents::Sessions::Turns.new(client: client)
          end
        end
      end
    end
  end
end
