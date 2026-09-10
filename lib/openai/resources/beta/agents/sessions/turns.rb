# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Turns
            # Retrieves a turn's current status, timestamps, usage, and error. Returns 404 if
            # the turn does not belong to the session. See
            # [session turns](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage#inspect-session-turns).
            #
            # @overload retrieve(turn_id, session_id:, request_options: {})
            #
            # @param turn_id [String]
            #   The ID of the turn.
            #
            # @param session_id [String]
            #   The ID of the session that owns the turn.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Sessions::Turn]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::TurnRetrieveParams
            def retrieve(turn_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::TurnRetrieveParams.dump_request(params)
              session_id = parsed.delete(:session_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/turns/%2$s", session_id, turn_id],
                model: OpenAI::Beta::Agents::Sessions::Turn,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Lists turns by creation time and turn ID. The after cursor is exclusive in the
            # selected order. See
            # [session turns](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage#inspect-session-turns).
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
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::TurnListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Sessions::Turn>]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::TurnListParams
            def list(session_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Sessions::TurnListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/turns", session_id],
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
            end
          end
        end
      end
    end
  end
end
