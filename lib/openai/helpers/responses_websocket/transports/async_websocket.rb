# frozen_string_literal: true

module OpenAI
  module Responses
    module Transports
      # Responses facade for the shared optional async WebSocket transport.
      #
      # @api private
      class AsyncWebSocket < OpenAI::WebSocket::AsyncWebSocketTransport
        def initialize
          error_factory = lambda do |url:, message: nil, http_status: nil, **_options|
            OpenAI::Errors::ResponsesConnectionError.new(
              url: url,
              message: message,
              http_status: http_status
            )
          end

          super(
            product_name: "Responses",
            error_class: OpenAI::Errors::ResponsesConnectionError,
            error_factory: error_factory,
            dependency_message: "Responses WebSockets require the async-websocket gem. Add it to your Gemfile."
          )
        end
      end
    end
  end
end
