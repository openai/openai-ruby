# frozen_string_literal: true

module OpenAI
  module Realtime
    # Internal block-scoped lifecycle manager for Realtime WebSocket connections.
    #
    # @api private
    class ConnectionManager < OpenAI::WebSocket::ConnectionManager
      # @api private
      def initialize(
        client:,
        query:,
        websocket_base_url:,
        transport:,
        request_options:,
        transport_options:,
        connection_class: OpenAI::Realtime::Connection
      )
        query = query
          .to_h
          .to_h do |key, value|
            [key.to_s.dup.freeze, value.to_s.dup.freeze]
          end
          .freeze
        base_url = websocket_base_url&.to_s&.dup&.freeze
        request = lambda do |&request_block|
          client.with_realtime_connection_request(
            path: "realtime",
            query: query,
            websocket_base_url: base_url,
            options: request_options,
            &request_block
          )
        end

        super(
          transport: transport,
          transport_options: transport_options,
          default_transport: -> { OpenAI::Realtime::Transports::AsyncWebSocket.new },
          connection_class: connection_class,
          request: request,
          block_error_message: "A block is required to open a Realtime WebSocket.",
          abort_after_block: -> (_connection, pending_error) { !pending_error.nil? },
          transport_error_message: "`transport` must respond to `open`",
          reserved_options_error_message: lambda do |reserved|
            "`transport_options` cannot include #{reserved.map(&:inspect).join(", ")}"
          end
        )
      end
    end
  end
end
