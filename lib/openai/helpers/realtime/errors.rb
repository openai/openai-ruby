# frozen_string_literal: true

module OpenAI
  module Errors
    # Raised when a Realtime WebSocket cannot be opened or used.
    class RealtimeConnectionError < OpenAI::Errors::WebSocketConnectionError
      private def default_message = "Realtime WebSocket connection error."

      private def sanitized_error_url(url)
        query = url.query
        return url if query.nil?

        contains_call_id = false
        parameters = query.split("&", -1).map do |parameter|
          name = parameter.partition("=").first
          next parameter unless URI.decode_www_form_component(name) == "call_id"

          contains_call_id = true
          "#{name}=[REDACTED]"
        end

        return url unless contains_call_id

        url.dup.tap { |sanitized| sanitized.query = parameters.join("&") }
      rescue ArgumentError, URI::Error
        url.dup.tap { |sanitized| sanitized.query = nil }
      end
    end

    # Raised when a Realtime WebSocket message cannot be parsed as a typed event.
    class RealtimeProtocolError < OpenAI::Errors::WebSocketProtocolError
      # @return [String]
      attr_reader :data

      # @return [StandardError, nil]
      def cause = @cause.nil? ? super : @cause

      # @api private
      #
      # @param data [String]
      # @param cause [StandardError, nil]
      def initialize(data:, cause: nil)
        @data = data
        @cause = cause
        super("Invalid Realtime WebSocket event.")
      end
    end
  end
end
