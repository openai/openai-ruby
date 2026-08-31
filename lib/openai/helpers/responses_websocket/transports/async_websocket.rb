# frozen_string_literal: true

module OpenAI
  module Responses
    module Transports
      # Responses-specific adapter over the SDK's optional async WebSocket transport.
      #
      # @api private
      class AsyncWebSocket
        def initialize
          @transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
        end

        def open(url:, headers:, timeout:, **options, &block)
          @transport.open(url: url, headers: headers, timeout: timeout, **options, &block)
        rescue OpenAI::Errors::RealtimeConnectionError => e
          message = if e.cause.is_a?(LoadError)
            "Responses WebSockets require the async-websocket gem. Add it to your Gemfile."
          end

          raise(
            OpenAI::Errors::ResponsesConnectionError.new(
              url: e.url,
              message: message,
              http_status: e.http_status
            ),
            cause: nil
          )
        end
      end
    end
  end
end
