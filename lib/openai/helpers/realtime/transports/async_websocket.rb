# frozen_string_literal: true

module OpenAI
  module Realtime
    module Transports
      # Compatibility facade for the shared async WebSocket transport.
      class AsyncWebSocket < OpenAI::WebSocket::AsyncWebSocketTransport
        ERROR_FACTORY = lambda do |url:, message: nil, cause: nil, http_status: nil|
          OpenAI::Errors::RealtimeConnectionError.new(
            url: url,
            message: message,
            cause: cause,
            http_status: http_status
          )
        end

        private_constant :ERROR_FACTORY

        # Compatibility wrapper for the socket class yielded before the shared
        # transport extraction.
        #
        # @api private
        class Socket < OpenAI::WebSocket::AsyncWebSocketTransport::Socket
          def initialize(connection, url:)
            super(connection, url: url, error_factory: ERROR_FACTORY)
          end
        end

        def initialize(&tls_configurator)
          super(
            product_name: "Realtime",
            error_class: OpenAI::Errors::RealtimeConnectionError,
            error_factory: ERROR_FACTORY,
            sensitive_query_parameter: "call_id",
&tls_configurator
          )
        end

        private def build_socket(connection, url:)
          Socket.new(connection, url: url)
        end
      end
    end
  end
end
