# frozen_string_literal: true

module OpenAI
  module Realtime
    # A live, typed Realtime WebSocket connection.
    class Connection < OpenAI::WebSocket::Connection
      include OpenAI::WebSocket::Protocol

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
        super
        @server_event_names = discriminator_values(OpenAI::Realtime::RealtimeServerEvent)
        @client_event_names = discriminator_values(OpenAI::Realtime::RealtimeClientEvent)
        @session = OpenAI::Realtime::ConnectionResources::Session.new(self)
        @response = OpenAI::Realtime::ConnectionResources::Response.new(self)
        @conversation = OpenAI::Realtime::ConnectionResources::Conversation.new(self)
        @input_audio_buffer = OpenAI::Realtime::ConnectionResources::InputAudioBuffer.new(self)
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

      private def event_type(event)
        super(event, message: "Realtime server event must be a JSON object") unless event.is_a?(Hash)
        super(event, message: "Realtime server event type must be a string or symbol")
      end

      private def validate_discriminator!(event, allowed, kind:)
        type = if event.key?(:type)
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

      private def connection_error(message)
        OpenAI::Errors::RealtimeConnectionError.new(url: @url, message: message)
      end

      private def closed_send_message = "Cannot send on a closed Realtime WebSocket."

      private def invalid_text_message = "Realtime WebSocket text must contain valid UTF-8"
    end
  end
end
