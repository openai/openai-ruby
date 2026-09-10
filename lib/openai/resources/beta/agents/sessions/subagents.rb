# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Subagents
            # @return [OpenAI::Resources::Beta::Agents::Sessions::Subagents::Items]
            attr_reader :items

            # @return [OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns]
            attr_reader :turns

            # Retrieves a subagent belonging to this session. See
            # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
            #
            # @overload retrieve(subagent_id, session_id:, request_options: {})
            #
            # @param subagent_id [String]
            #   The ID of the subagent in this session.
            #
            # @param session_id [String]
            #   The ID of the session.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Subagent]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::SubagentRetrieveParams
            def retrieve(subagent_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::SubagentRetrieveParams.dump_request(params)
              session_id = parsed.delete(:session_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/subagents/%2$s", session_id, subagent_id],
                model: OpenAI::Beta::Subagent,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Lists subagents in a session, including nested and closed subagents. See
            # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
            #
            # @overload list(session_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param session_id [String]
            #   The ID of the session.
            #
            # @param after [String]
            #   Return resources after this resource ID in the selected order.
            #
            # @param limit [Integer]
            #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::SubagentListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Subagent>]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::SubagentListParams
            def list(session_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Sessions::SubagentListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/subagents", session_id],
                query: query,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Subagent,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
              @items = OpenAI::Resources::Beta::Agents::Sessions::Subagents::Items.new(client: client)
              @turns = OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns.new(client: client)
            end
          end
        end
      end
    end
  end
end
