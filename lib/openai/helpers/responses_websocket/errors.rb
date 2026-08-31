# frozen_string_literal: true

module OpenAI
  module Errors
    # Raised when a Responses WebSocket cannot be opened or used.
    class ResponsesConnectionError < OpenAI::Errors::Error
      # @return [URI::Generic]
      attr_reader :url

      # @return [Integer, nil]
      attr_reader :http_status

      # @return [Exception, nil]
      def cause = nil

      # @api private
      def initialize(url:, message: nil, http_status: nil)
        @url = sanitized_error_url(url)
        @http_status = http_status
        super(message || "Responses WebSocket connection error.")
      end

      private def sanitized_error_url(url)
        sanitized = url.dup
        sanitized.user = nil if sanitized.respond_to?(:user=)
        sanitized.password = nil if sanitized.respond_to?(:password=)
        sanitized.query = nil if sanitized.respond_to?(:query=)
        sanitized.fragment = nil if sanitized.respond_to?(:fragment=)
        sanitized
      rescue ArgumentError, URI::Error
        URI("wss://invalid")
      end
    end

    # Raised when a Responses WebSocket message is malformed.
    class ResponsesProtocolError < OpenAI::Errors::Error
      def cause = nil

      # @api private
      def initialize
        super("Invalid Responses WebSocket event.")
      end
    end

    # Raised before a malformed client event can be written.
    class ResponsesClientEventError < OpenAI::Errors::Error
      def cause = nil

      # @api private
      def initialize
        super("Invalid Responses WebSocket client event.")
      end
    end

    # Raised when a write may or may not have reached the server.
    class ResponsesSendError < ResponsesConnectionError
      # @return [Symbol, :unknown]
      attr_reader :outcome

      # @api private
      def initialize(url:)
        @outcome = :unknown
        super(url: url, message: "Responses WebSocket send outcome is unknown.")
      end
    end
  end
end
