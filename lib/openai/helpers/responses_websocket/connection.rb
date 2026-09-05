# frozen_string_literal: true

module OpenAI
  module Responses
    # A live, typed Responses WebSocket connection.
    class Connection < OpenAI::WebSocket::Connection
      include OpenAI::WebSocket::Protocol

      # @return [OpenAI::Responses::ConnectionResources::Response]
      attr_reader :response

      # @api private
      def initialize(socket:, url:)
        super
        @poisoned = false
        @state = :open
        @owner_thread = Thread.current.object_id
        @reading = false
        @server_event_names = discriminator_values(OpenAI::Responses::ResponsesServerEvent)
        @response = OpenAI::Responses::ConnectionResources::Response.new(self)
      end

      def each
        return enum_for(__method__) unless block_given?

        with_read_lease do
          while (event = read_one)
            yield(event)
          end
        end

        self
      end

      def receive
        with_read_lease { read_one }
      end

      # Receive the next raw WebSocket message while preserving Responses'
      # single-owner and one-reader guarantees.
      #
      # @api private
      def receive_raw
        with_read_lease { read_raw }
      end

      # Validate, encode, and send a Responses client event.
      #
      # @return [nil]
      def send_event(event)
        assert_owner!
        raise connection_error("Cannot send on a closed Responses WebSocket.") if poisoned? || closed?

        write_encoded(JSON.generate(encode_client_event(event)))
      rescue OpenAI::Errors::ResponsesConnectionError,
        OpenAI::Errors::ResponsesClientEventError,
        OpenAI::Errors::ResponsesSendError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesClientEventError.new, cause: nil
      end

      # Send an already encoded text message while preserving Responses'
      # single-owner and terminal-write guarantees.
      #
      # @api private
      def send_raw(data)
        assert_owner!
        raise connection_error("Cannot send on a closed Responses WebSocket.") if poisoned? || closed?

        super
      end

      # @api private
      def poisoned? = @poisoned

      def close(code: 1000, reason: "")
        assert_owner!
        return if socket_closed?
        return abort if poisoned?

        super
        @state = :closed
        nil
      rescue OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        @state = :closed
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      # @api private
      def abort
        assert_owner!
        return if socket_closed?

        super
        @state = :closed
        nil
      rescue OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        @state = :closed
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      def closed? = @state == :closed || super

      private def parse_event(data)
        parsed = JSON.parse(data, symbolize_names: true)
        type = event_type(parsed, message: "Responses server event must be a JSON object")
        unless @server_event_names.key?(type.to_s)
          return OpenAI::Responses::UnknownServerEvent.new(data: parsed)
        end

        state = OpenAI::Internal::Type::Converter.new_coerce_state
        OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Responses::ResponsesServerEvent,
          parsed,
          state: state
        )
      rescue OpenAI::Errors::ResponsesProtocolError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesProtocolError.new, cause: nil
      end

      private def read_one
        data = read_raw
        return nil if data.nil?

        parse_event(data.to_str)
      rescue OpenAI::Errors::ResponsesProtocolError, OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      private def read_raw
        assert_owner!
        return nil if closed?

        data = begin
          read_raw_message
        rescue OpenAI::Errors::ResponsesConnectionError
          @poisoned = true
          raise
        rescue StandardError
          @poisoned = true
          raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
        end

        @state = :closed if data.nil?
        data
      end

      private def encode_client_event(event)
        validate_event_tree!(event)
        payload = if event.is_a?(Hash)
          OpenAI::Internal::Type::Unknown.dump(event, state: {can_retry: true})
        else
          OpenAI::Internal::Type::Converter.dump(OpenAI::Responses::ResponsesClientEvent, event)
        end

        raise OpenAI::Errors::ResponsesClientEventError.new unless payload.is_a?(Hash)

        normalize_event_keys(payload)
      rescue OpenAI::Errors::ResponsesClientEventError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesClientEventError.new, cause: nil
      end

      private def write_encoded(data)
        send_raw(data)
      end

      private def write_text(text)
        super
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::ResponsesSendError.new(url: @url), cause: nil
      end

      private def with_read_lease
        acquired = false
        assert_owner!
        if @reading
          raise connection_error("Responses WebSocket already has an active reader.")
        end

        @reading = true
        acquired = true
        yield
      ensure
        @reading = false if acquired
      end

      private def assert_owner!
        return if @owner_thread == Thread.current.object_id

        raise connection_error("Responses WebSocket connections are single-owner.")
      end

      private def validate_event_tree!(value, active = {}.compare_by_identity)
        case value
        when OpenAI::Internal::Type::BaseModel
          guard_cycle!(value, active)
          begin
            data = value.to_h
            reject_duplicate_serialized_model_keys!(value.class, data)
            validate_event_tree!(data, active)
          ensure
            active.delete(value)
          end

        when Hash
          guard_cycle!(value, active)
          reject_duplicate_semantic_keys!(value)
          begin
            value.each_value { |item| validate_event_tree!(item, active) }
          ensure
            active.delete(value)
          end

        when Array
          guard_cycle!(value, active)
          begin
            value.each { |item| validate_event_tree!(item, active) }
          ensure
            active.delete(value)
          end
        end

        nil
      end

      private def reject_duplicate_serialized_model_keys!(model, data)
        serialized_keys = data.keys.map do |key|
          name = key.is_a?(String) ? key.to_sym : key
          field = model.known_fields[name]
          field ? field.fetch(:api_name) : name
        end

        return if serialized_keys.map(&:to_s).uniq.length == serialized_keys.length

        raise OpenAI::Errors::ResponsesClientEventError.new
      end

      private def guard_cycle!(value, active)
        raise OpenAI::Errors::ResponsesClientEventError.new if active.key?(value)

        active[value] = true
      end

      private def reject_duplicate_semantic_keys!(payload)
        keys = payload.keys
        unless keys.all? { |key| key.is_a?(String) || key.is_a?(Symbol) }
          raise OpenAI::Errors::ResponsesClientEventError.new
        end

        return if keys.map(&:to_s).uniq.length == keys.length

        raise OpenAI::Errors::ResponsesClientEventError.new
      end

      private def normalize_event_keys(value)
        case value
        when Hash
          value.to_h do |key, item|
            normalized_key = key.is_a?(String) ? key.to_sym : key
            [normalized_key, normalize_event_keys(item)]
          end

        when Array
          value.map { |item| normalize_event_keys(item) }
        else
          value
        end
      end

      private def connection_error(message)
        OpenAI::Errors::ResponsesConnectionError.new(url: @url, message: message)
      end

    end
  end
end
