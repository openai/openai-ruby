# frozen_string_literal: true

module OpenAI
  module Realtime
    module Transports
      # Compatibility facade for the shared async WebSocket transport.
      class AsyncWebSocket < OpenAI::WebSocket::AsyncWebSocketTransport
        def initialize(&tls_configurator)
          error_factory = lambda do |url:, message: nil, cause: nil, http_status: nil|
            OpenAI::Errors::RealtimeConnectionError.new(
              url: url,
              message: message,
              cause: cause,
              http_status: http_status
            )
          end

          super(
            product_name: "Realtime",
            error_class: OpenAI::Errors::RealtimeConnectionError,
            error_factory: error_factory,
            sensitive_query_parameter: "call_id",
&tls_configurator
          )
        end
      end
    end
  end
end
