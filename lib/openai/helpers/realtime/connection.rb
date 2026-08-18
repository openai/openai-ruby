# frozen_string_literal: true

module OpenAI
  module Realtime
    # A live, typed Realtime WebSocket connection.
    class Connection
      include Enumerable

      # @return [OpenAI::Realtime::ConnectionResources::Session]
      attr_reader :session

      # @return [OpenAI::Realtime::ConnectionResources::Response]
      attr_reader :response

      # @return [OpenAI::Realtime::ConnectionResources::Conversation]
      attr_reader :conversation

      # @return [OpenAI::Realtime::ConnectionResources::InputAudioBuffer]
      attr_reader :input_audio_buffer

      # @api private
      def initialize(socket:, url:)
        @socket = socket
        @url = url
        @server_event_names = discriminator_values(OpenAI::Realtime::RealtimeServerEvent)
        @client_event_names = discriminator_values(OpenAI::Realtime::RealtimeClientEvent)
        @session = OpenAI::Realtime::ConnectionResources::Session.new(self)
        @response = OpenAI::Realtime::ConnectionResources::Response.new(self)
        @conversation = OpenAI::Realtime::ConnectionResources::Conversation.new(self)
        @input_audio_buffer = OpenAI::Realtime::ConnectionResources::InputAudioBuffer.new(self)
      end

      # @return [URI::Generic]
      attr_reader :url

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
        event = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Realtime::RealtimeServerEvent,
          parsed,
          state: state
        )
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
        send_raw(encode_client_event(event))
      end

      private def encode_client_event(event)
        if event.is_a?(Hash)
          validate_discriminator!(event, @client_event_names, kind: "client")
        end
        normalized = OpenAI::Internal::Type::Converter.dump(
          OpenAI::Realtime::RealtimeClientEvent,
          event
        )
        state = OpenAI::Internal::Type::Converter.new_coerce_state
        coerced = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Realtime::RealtimeClientEvent,
          normalized,
          state: state
        )
        if (cause = coercion_error(state))
          raise cause
        end
        payload = OpenAI::Internal::Type::Converter.dump(OpenAI::Realtime::RealtimeClientEvent, coerced)
        validate_discriminator!(payload, @client_event_names, kind: "client")
        JSON.generate(payload)
      rescue StandardError => e
        raise ArgumentError.new("Invalid Realtime client event."), cause: e
      end

      # Send an already encoded text message.
      def send_raw(data)
        if closed?
          raise OpenAI::Errors::RealtimeConnectionError.new(
            url: @url,
            message: "Cannot send on a closed Realtime WebSocket."
          )
        end
        text = data.dup
        text.force_encoding(Encoding::UTF_8) if text.encoding == Encoding::BINARY
        text = text.encode(Encoding::UTF_8) unless text.encoding == Encoding::UTF_8
        unless text.valid_encoding?
          raise ArgumentError, "Realtime WebSocket text must contain valid UTF-8"
        end

        @socket.write(text)
        nil
      end

      # Close the connection.
      def close(code: 1000, reason: "")
        return if closed?

        @socket.close(code: code, reason: reason)
        nil
      end

      # Abort without waiting for the WebSocket close handshake.
      #
      # @api private
      def abort
        return if closed?

        @socket.abort
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
