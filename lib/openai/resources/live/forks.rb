# frozen_string_literal: true

require_relative "../../helpers/websocket/resource"

module OpenAI
  module Resources
    class Live
      class Forks
        include OpenAI::WebSocket::Resource

        # @api private
        def __websocket_request(session_id, query: {})
          {method: :get, path: ["live/sessions/%1$s/fork", session_id], query: query, security: {bearer_auth: true}}
        end

        # @api private
        def __websocket_client_event
          OpenAI::Models::Live::ForkClientEvent
        end

        # @api private
        def __websocket_server_event
          OpenAI::Models::Live::ForkServerEvent
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
