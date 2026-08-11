# frozen_string_literal: true

module OpenAI
  module Realtime
    module Transports
      # Default Realtime transport backed by the optional async-websocket gem.
      class AsyncWebSocket
        class Socket
          # @api private
          def initialize(connection, url:)
            @connection = connection
            @url = url
          end

          def read
            @connection.read
          rescue StandardError => e
            raise OpenAI::Errors::RealtimeConnectionError.new(url: @url, cause: e)
          end

          def write(message)
            @connection.write(message)
            @connection.flush
          rescue StandardError => e
            raise OpenAI::Errors::RealtimeConnectionError.new(url: @url, cause: e)
          end

          def close(code: 1000, reason: "")
            @connection.close(code, reason)
          rescue StandardError => e
            raise OpenAI::Errors::RealtimeConnectionError.new(url: @url, cause: e)
          end

          def closed? = @connection.closed?
        end

        def open(url:, headers:, timeout:, **endpoint_options)
          load_dependencies(url)

          # Classic WebSocket negotiation uses HTTP/1.1. Pinning ALPN also avoids an
          # HTTP/2 selection on servers that advertise both protocols.
          options = {
            alpn_protocols: ::Async::HTTP::Protocol::HTTP11.names,
            **endpoint_options
          }
          endpoint = ::Async::HTTP::Endpoint.parse(
            url.to_s,
            timeout: timeout,
            **options
          )
          block_error = nil
          ::Async::WebSocket::Client.connect(endpoint, headers: headers) do |connection|
            yield(Socket.new(connection, url: url))
          rescue StandardError => e
            block_error = e
            raise
          end
        rescue OpenAI::Errors::RealtimeConnectionError
          raise
        rescue StandardError => e
          raise if e.equal?(block_error)

          raise OpenAI::Errors::RealtimeConnectionError.new(url: url, cause: e)
        end

        private def load_dependencies(url)
          require("async/websocket/client")
          require("async/http/endpoint")
        rescue LoadError => e
          message =
            "Realtime WebSockets require the `async-websocket` gem. " \
            "Add `gem \"async-websocket\"` to your Gemfile."
          raise OpenAI::Errors::RealtimeConnectionError.new(url: url, message: message, cause: e)
        end
      end
    end
  end
end
