# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared event codec for generated bindings and specialized product facades.
    #
    # @api private
    class TypedConnection < Connection
      include GuardedConnection
      include Protocol

      def initialize(socket:, url:, client_event:, server_event:)
        super(socket: socket, url: url)
        @client_event = client_event
        @server_event = server_event
        variants = client_event.respond_to?(:variants) ? client_event.variants : [client_event]
        @client_event_types = variants.map do |variant|
          variant.fields.dig(:type, :type) if variant.respond_to?(:fields)
        end

        variants = server_event.respond_to?(:variants) ? server_event.variants : [server_event]
        @server_event_types = variants.filter_map do |variant|
          type = variant&.fields&.dig(:type, :type)
          [type, variant] if type
        end
      end

      def send_event(event)
        send_raw(encode_client_event(event))
      end

      private def encode_client_event(event)
        validate_event_tree!(event)
        event_type(event, message: client_event_error_message) if event.is_a?(Hash)
        payload = @client_event ? OpenAI::Internal::Type::Converter.dump(@client_event, event) : event
        type = event_type(payload, message: client_event_error_message)
        if @client_event && !@client_event_types.any? { _1.nil? || _1 === type.to_sym || _1 === type.to_s }
          raise ArgumentError, client_event_error_message
        end

        OpenAI::Helpers::StructuredOutput.prepare_configuration_updates!(payload) if @client_event
        payload = coerce_client_event(payload) if @client_event
        payload = OpenAI::Internal::Type::Converter.dump(@client_event, payload) if @client_event
        validate_event_tree!(payload, json_only: true)
        generate_json(payload)
      rescue StandardError, SystemStackError
        raise ArgumentError, client_event_error_message, cause: nil
      end

      def parse_event(data)
        parsed = parse_json(data)
        type = event_type(parsed, message: "WebSocket server event must be an object with a string type")
        _, model = @server_event_types.find { |event_type,| event_type === type.to_sym }
        return unknown_server_event(parsed) unless model

        event = coerce(@server_event, parsed)
        validate_wire_field_names!(event, parsed)
      rescue StandardError, SystemStackError
        raise protocol_error, cause: nil
      end

      private def coerce_client_event(payload) = coerce(@client_event, payload)

      private def coerce(type, value)
        state = OpenAI::Internal::Type::Converter.new_coerce_state
        result = OpenAI::Internal::Type::Converter.coerce(type, value, state: state)
        if state[:error] || !state.fetch(:exactness).fetch(:no).zero?
          raise ArgumentError, "Invalid WebSocket event."
        end

        result
      end

      private def client_event_error_message = "Invalid WebSocket client event."

      private def unknown_server_event(payload) = payload

      private def protocol_error = OpenAI::Errors::WebSocketProtocolError.new("Invalid WebSocket server event.")

      private def connection_error(message) = BindingConnectionError.new(url: @url, message: message)

      private def transport_error = connection_error("WebSocket transport failed.")

      private def failed_read_message = "Cannot read from a failed WebSocket."
    end

    # @api private
    class BindingConnectionError < OpenAI::Errors::WebSocketConnectionError
      def initialize(url:, message: nil, http_status: nil, **_options)
        super(url: url, message: message, http_status: http_status)
      end

      private def sanitized_error_url(url)
        url&.dup&.tap do |value|
          value.userinfo = nil
          value.query = nil
          value.fragment = nil
        end
      end
    end
  end
end
