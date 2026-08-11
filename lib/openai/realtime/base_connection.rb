# frozen_string_literal: true

module OpenAI
  module Realtime
    # Shared protocol machinery for live Realtime WebSocket connections.
    #
    # @api private
    class BaseConnection
      include Enumerable

      # @return [URI::Generic]
      attr_reader :url

      # @api private
      def initialize(socket:, url:, server_event_type:, client_event_type:)
        @socket = socket
        @url = url
        @server_event_type = server_event_type
        @client_event_type = client_event_type
        @server_event_names = discriminator_values(@server_event_type)
        @client_event_names = discriminator_values(@client_event_type)
      end

      # Yield server events until the remote peer closes the connection.
      def each
        return enum_for(__method__) unless block_given?

        while (event = receive)
          yield(event)
        end
        self
      end

      # Receive and parse the next server event, or return nil after a clean close.
      def receive
        data = receive_raw
        return nil if data.nil?

        parse_event(data)
      end

      # Receive the next raw WebSocket message.
      def receive_raw
        message = @socket.read
        message&.to_str
      end

      # Parse raw JSON as a typed server event. Valid events that are newer than this
      # SDK remain observable as {UnknownServerEvent} values.
      def parse_event(data)
        parsed = JSON.parse(data, symbolize_names: true)
        type = event_type(parsed)
        unless @server_event_names.key?(type.to_s)
          return OpenAI::Realtime::UnknownServerEvent.new(data: parsed)
        end

        state = OpenAI::Internal::Type::Converter.new_coerce_state
        event = OpenAI::Internal::Type::Converter.coerce(@server_event_type, parsed, state: state)
        if (cause = coercion_error(state))
          raise OpenAI::Errors::RealtimeProtocolError.new(data: data, cause: cause)
        end
        event
      rescue OpenAI::Errors::RealtimeProtocolError
        raise
      rescue StandardError => e
        raise OpenAI::Errors::RealtimeProtocolError.new(data: data, cause: e)
      end

      # Validate, encode, and send a typed client event.
      def send_event(event)
        validate_discriminator!(event, @client_event_names, kind: "client") if event.is_a?(Hash)
        state = OpenAI::Internal::Type::Converter.new_coerce_state
        coerced = OpenAI::Internal::Type::Converter.coerce(@client_event_type, event, state: state)
        if (cause = coercion_error(state))
          raise ArgumentError.new("Invalid Realtime client event: #{cause.message}"), cause: cause
        end
        payload = OpenAI::Internal::Type::Converter.dump(@client_event_type, coerced)
        validate_discriminator!(payload, @client_event_names, kind: "client")
        send_raw(JSON.generate(payload))
      end

      # Send an already encoded text message.
      def send_raw(data)
        if closed?
          raise OpenAI::Errors::RealtimeConnectionError.new(
            url: @url,
            message: "Cannot send on a closed Realtime WebSocket."
          )
        end
        @socket.write(data)
        nil
      end

      # Close the connection.
      def close(code: 1000, reason: "")
        return if closed?

        @socket.close(code: code, reason: reason)
        nil
      end

      # @return [Boolean]
      def closed? = @socket.closed?

      private def discriminator_values(union)
        union.variants.to_h do |variant|
          value = variant.fields.fetch(:type).fetch(:const)
          [value.to_s, true]
        end
      end

      private def event_type(event)
        unless event.is_a?(Hash)
          raise ArgumentError, "Realtime server event must be a JSON object"
        end

        type = event[:type]
        return type if type.is_a?(String) || type.is_a?(Symbol)

        raise ArgumentError, "Realtime server event type must be a string or symbol"
      end

      private def validate_discriminator!(event, allowed, kind:)
        type =
          if event.key?(:type)
            event.fetch(:type)
          elsif event.key?("type")
            event.fetch("type")
          end
        return if type && allowed.key?(type.to_s)

        raise ArgumentError, "Unknown Realtime #{kind} event type: #{type.inspect}"
      end

      private def coercion_error(state)
        return state[:error] if state[:error]
        return if state.fetch(:exactness).fetch(:no).zero?

        ArgumentError.new("Realtime event is missing required fields or contains invalid values")
      end
    end
  end
end
