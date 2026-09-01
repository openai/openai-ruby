# frozen_string_literal: true

module OpenAI
  module Responses
    # Internal block-scoped lifecycle manager for Responses WebSocket connections.
    #
    # @api private
    class ConnectionManager < OpenAI::WebSocket::ConnectionManager
      # @api private
      def initialize(client:, websocket_base_url:, transport:, request_options:, transport_options:)
        base_url = websocket_base_url&.to_s&.dup&.freeze
        request = lambda do |&request_block|
          client.with_responses_websocket_connection_request(
            websocket_base_url: base_url,
            options: request_options,
            &request_block
          )
        end

        super(
          transport: transport,
          transport_options: transport_options,
          default_transport: -> { OpenAI::Responses::Transports::AsyncWebSocket.new },
          connection_class: OpenAI::Responses::Connection,
          request: request,
          block_error_message: "A block is required to open a Responses WebSocket.",
          abort_after_block: lambda do |connection, pending_error|
            !pending_error.nil? || connection.poisoned?
          end
        )
      end
    end
  end
end
