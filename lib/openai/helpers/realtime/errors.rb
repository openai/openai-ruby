# frozen_string_literal: true

module OpenAI
  module Errors
    # Raised when a Realtime WebSocket cannot be opened or used.
    class RealtimeConnectionError < OpenAI::Errors::Error
      # @return [URI::Generic]
      attr_reader :url

      # HTTP status returned by a failed WebSocket upgrade, when available.
      #
      # @api private
      #
      # @return [Integer, nil]
      attr_reader :http_status

      # @return [Exception, nil]
      def cause = @cause.nil? ? super : @cause

      # @api private
      #
      # @param url [URI::Generic]
      # @param message [String, nil]
      # @param cause [Exception, nil]
      # @param http_status [Integer, nil]
      def initialize(url:, message: nil, cause: nil, http_status: nil)
        @url = url
        @cause = cause
        @http_status = http_status
        super(message || "Realtime WebSocket connection error.")
      end
    end

    # Raised when a Realtime WebSocket message cannot be parsed as a typed event.
    class RealtimeProtocolError < OpenAI::Errors::Error
      # @return [String]
      attr_reader :data

      # @return [StandardError, nil]
      def cause = @cause.nil? ? super : @cause

      # @api private
      #
      # @param data [String]
      # @param message [String, nil]
      # @param cause [StandardError, nil]
      def initialize(data:, message: nil, cause: nil)
        @data = data
        @cause = cause
        detail = cause && !cause.message.empty? ? ": #{cause.message}" : "."
        super(message || "Invalid Realtime WebSocket event#{detail}")
      end
    end
  end
end
