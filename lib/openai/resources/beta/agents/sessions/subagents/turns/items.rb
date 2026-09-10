# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Subagents
            class Turns
              class Items
                # Lists items belonging to one turn of this subagent. See
                # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
                #
                # @overload list(turn_id, session_id:, subagent_id:, after: nil, limit: nil, order: nil, request_options: {})
                #
                # @param turn_id [String]
                #   Path param: The ID of a turn belonging to this subagent.
                #
                # @param session_id [String]
                #   Path param: The ID of the session.
                #
                # @param subagent_id [String]
                #   Path param: The ID of the subagent in this session.
                #
                # @param after [String]
                #   Query param: Return resources after this resource ID in the selected order.
                #
                # @param limit [Integer]
                #   Query param: The maximum number of resources to return, between 1 and 100.
                #   Defaults to 20.
                #
                # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::Subagents::Turns::ItemListParams::Order]
                #   Query param: The order in which resources are returned. Defaults to `desc`.
                #
                # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
                #
                # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::AgentSessionMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentSessionItem::FunctionCallOutput, OpenAI::Models::Beta::AgentSessionItem::AgentMessage, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem>]
                #
                # @see OpenAI::Models::Beta::Agents::Sessions::Subagents::Turns::ItemListParams
                def list(turn_id, params)
                  parsed, options = OpenAI::Beta::Agents::Sessions::Subagents::Turns::ItemListParams.dump_request(
                    params
                  )
                  session_id = parsed.delete(:session_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end

                  subagent_id = parsed.delete(:subagent_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end

                  query = OpenAI::Internal::Util.encode_query_params(parsed)
                  @client.request(
                    method: :get,
                    path: [
                      "agents/sessions/%1$s/subagents/%2$s/turns/%3$s/items",
                      session_id,
                      subagent_id,
                      turn_id
                    ],
                    query: query,
                    page: OpenAI::Internal::CursorPage,
                    model: OpenAI::Beta::AgentSessionItem,
                    security: {bearer_auth: true},
                    options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
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
  end
end
