# frozen_string_literal: true

module OpenAI
  module Realtime
    # Internal block-scoped lifecycle manager for Realtime WebSocket connections.
    #
    # @api private
    class ConnectionManager
      RESERVED_TRANSPORT_OPTIONS = [
        :alpn_protocols,
        :headers,
        :hostname,
        :port,
        :protocol,
        :scheme,
        :ssl_context,
        :timeout,
        :url
      ].freeze

      # @api private
      def initialize(
        client:,
        model:,
        websocket_base_url:,
        transport:,
        request_options:,
        transport_options:
      )
        @client = client
        @model = model
        @websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
        @transport = transport
        @request_options = request_options
        transport_options = transport_options.dup.freeze
        reserved_options = transport_options.keys.select do |key|
          (key.is_a?(String) || key.is_a?(Symbol)) && RESERVED_TRANSPORT_OPTIONS.include?(key.to_sym)
        end
        unless reserved_options.empty?
          raise ArgumentError,
                "`transport_options` cannot include #{reserved_options.map(&:inspect).join(', ')}"
        end
        @transport_options = transport_options
      end

      # Open the WebSocket and yield a typed connection for the lifetime of the block.
      #
      # @api private
      #
      # @yieldparam connection [OpenAI::Realtime::Connection]
      # @return [Object]
      def open
        raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block_given?

        transport = @transport || OpenAI::Realtime::Transports::AsyncWebSocket.new
        unless transport.respond_to?(:open)
          raise ArgumentError, "`transport` must respond to `open`"
        end

        @client.with_realtime_connection_request(
          path: "realtime",
          query: {"model" => @model},
          websocket_base_url: @websocket_base_url,
          options: @request_options
        ) do |request, mark_handshake_completed|
          transport.open(
            url: request.fetch(:url),
            headers: request.fetch(:headers),
            timeout: request.fetch(:timeout),
            **@transport_options
          ) do |socket|
            mark_handshake_completed.call
            connection = OpenAI::Realtime::Connection.new(socket: socket, url: request.fetch(:url))
            begin
              yield(connection)
            ensure
              pending_error = $ERROR_INFO
              begin
                if pending_error
                  connection.abort unless connection.closed?
                else
                  connection.close unless connection.closed?
                end
              rescue StandardError
                raise if pending_error.nil?
              end
            end
          end
        end
      end
    end
  end
end
