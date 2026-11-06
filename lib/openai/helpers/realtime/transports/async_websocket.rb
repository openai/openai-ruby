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

        # The optional transport discards an empty close frame's status. Restore
        # it only on sockets owned by automatic recovery, after native validation.
        module RecoverNoStatusClose
          def receive_close(frame)
            super
            if frame.payload.empty?
              raise ::Protocol::WebSocket::ClosedError.new("Peer closed without a status", 1005)
            end
          end
        end

        private_constant :RecoverNoStatusClose

        # Compatibility wrapper for the socket class yielded before the shared
        # transport extraction.
        #
        # @api private
        class Socket < OpenAI::WebSocket::AsyncWebSocketTransport::Socket
          def initialize(connection, url:)
            super(connection, url: url, error_factory: ERROR_FACTORY)
          end

          # @api private
          def enable_no_status_recovery
            @connection.extend(RecoverNoStatusClose) if @connection.respond_to?(:receive_close)
            nil
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
