# frozen_string_literal: true

module OpenAI
  module Errors
    # A disconnected send could not be retained within the caller's byte budget.
    class RealtimeQueueFullError < OpenAI::Errors::Error
      def initialize = super("Realtime send queue is full; event was not accepted.")
    end

    # Terminal recovery failure. Payloads are available only through explicit
    # accessors, never included in the message or default exception rendering.
    class RealtimeReconnectError < OpenAI::Errors::Error
      # @api private
      class RecoveryData
        def initialize(unsent_messages, uncertain_message)
          @values = [unsent_messages.dup.freeze, uncertain_message].freeze
        end

        def values
          @values || raise(OpenAI::Errors::Error, "Realtime recovery data is unavailable on a deserialized diagnostic.")
        end

        # Exception collectors may render shallow instance variables.
        def inspect = "#<RealtimeReconnectError::RecoveryData [REDACTED]>"

        alias_method :to_s, :inspect

        # Preserve native exception serialization, but never serialize recovery data.
        def encode_with(coder)
          coder.map = {}
        end

        def init_with(_coder)
          @values = nil
        end

        def marshal_dump = []

        def marshal_load(_values)
          @values = nil
        end
      end

      private_constant :RecoveryData

      # @return [Array<String>]
      def unsent_messages = @recovery_data.values.first

      # @return [String, nil]
      def uncertain_message = @recovery_data.values.last

      # @api private
      def initialize(message:, unsent_messages: [], uncertain_message: nil)
        @recovery_data = RecoveryData.new(unsent_messages, uncertain_message)
        super(message)
      end
    end

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
