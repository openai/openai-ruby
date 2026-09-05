# frozen_string_literal: true

module OpenAI
  module Errors
    # Base class for SDK WebSocket connection failures.
    #
    # @api private
    class WebSocketConnectionError < OpenAI::Errors::Error
      attr_reader :url, :http_status

      def cause = @cause.nil? ? super : @cause

      # @api private
      def initialize(url:, message: nil, cause: nil, http_status: nil)
        @url = sanitized_error_url(url)
        @cause = cause
        @http_status = http_status
        super(message || default_message)
      end

      private def default_message = "WebSocket connection error."

      private def sanitized_error_url(url) = url
    end

    # Base class for malformed WebSocket messages.
    #
    # @api private
    class WebSocketProtocolError < OpenAI::Errors::Error
    end
  end
end
