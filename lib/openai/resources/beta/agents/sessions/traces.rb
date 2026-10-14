# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Traces
            # Lists published root-turn traces as OTLP JSON, ordered by turn creation time and
            # ID. Unpublished traces are skipped. Each page returns data available when read;
            # it does not wait for late traces. Trace reads and the JSON response are limited
            # to 16 MiB per request. If the limit is exceeded, request fewer traces.
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
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::TraceListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Sessions::SessionTrace>]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::TraceListParams
            def list(session_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Sessions::TraceListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/traces", session_id],
                query: query,
                headers: {"openai-beta" => "agents=v1"},
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Agents::Sessions::SessionTrace,
                security: {bearer_auth: true},
                options: options
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
