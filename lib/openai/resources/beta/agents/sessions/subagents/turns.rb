# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Subagents
            class Turns
              # @return [OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns::Items]
              attr_reader :items

              # Retrieves a turn belonging to this subagent. See
              # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
              #
              # @overload retrieve(turn_id, session_id:, subagent_id:, request_options: {})
              #
              # @param turn_id [String]
              #   The ID of a turn belonging to this subagent.
              #
              # @param session_id [String]
              #   The ID of the session.
              #
              # @param subagent_id [String]
              #   The ID of the subagent in this session.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Beta::Agents::Sessions::Turn]
              #
              # @see OpenAI::Models::Beta::Agents::Sessions::Subagents::TurnRetrieveParams
              def retrieve(turn_id, params)
                parsed, options = OpenAI::Beta::Agents::Sessions::Subagents::TurnRetrieveParams.dump_request(params)
                session_id = parsed.delete(:session_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end

                subagent_id = parsed.delete(:subagent_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end

                @client.request(
                  method: :get,
                  path: ["agents/sessions/%1$s/subagents/%2$s/turns/%3$s", session_id, subagent_id, turn_id],
                  model: OpenAI::Beta::Agents::Sessions::Turn,
                  security: {bearer_auth: true},
                  options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
                )
              end

              # Lists all turns of this subagent, including turns after a resume. See
              # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
              #
              # @overload list(subagent_id, session_id:, after: nil, limit: nil, order: nil, request_options: {})
              #
              # @param subagent_id [String]
              #   Path param: The ID of the subagent in this session.
              #
              # @param session_id [String]
              #   Path param: The ID of the session.
              #
              # @param after [String]
              #   Query param: Return resources after this resource ID in the selected order.
              #
              # @param limit [Integer]
              #   Query param: The maximum number of resources to return, between 1 and 100.
              #   Defaults to 20.
              #
              # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::Subagents::TurnListParams::Order]
              #   Query param: The order in which resources are returned. Defaults to `desc`.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Sessions::Turn>]
              #
              # @see OpenAI::Models::Beta::Agents::Sessions::Subagents::TurnListParams
              def list(subagent_id, params)
                parsed, options = OpenAI::Beta::Agents::Sessions::Subagents::TurnListParams.dump_request(params)
                session_id = parsed.delete(:session_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end

                query = OpenAI::Internal::Util.encode_query_params(parsed)
                @client.request(
                  method: :get,
                  path: ["agents/sessions/%1$s/subagents/%2$s/turns", session_id, subagent_id],
                  query: query,
                  page: OpenAI::Internal::CursorPage,
                  model: OpenAI::Beta::Agents::Sessions::Turn,
                  security: {bearer_auth: true},
                  options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
                )
              end

              # @api private
              #
              # @param client [OpenAI::Client]
              def initialize(client:)
                @client = client
                @items = OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns::Items.new(client: client)
              end
            end
          end
        end
      end
    end
  end
end
