# frozen_string_literal: true

module OpenAI
  module Responses
    # A live, typed Responses WebSocket connection.
    class Connection
      include Enumerable

      STREAM_ID = /\A[A-Za-z0-9_.-]{1,256}\z/
      MAX_NAMED_STREAM_IDS = 32
      private_constant :STREAM_ID, :MAX_NAMED_STREAM_IDS

      # @return [OpenAI::Responses::ConnectionResources::Response]
      attr_reader :response

      # @return [URI::Generic]
      attr_reader :url

      # @api private
      def initialize(socket:, url:)
        @socket = socket
        @url = url
        @state = :open
        @owner_thread = Thread.current.object_id
        @reading = false
        @named_stream_ids = {}
        @server_event_names = discriminator_values(OpenAI::Responses::ResponsesServerEvent)
        @response = OpenAI::Responses::ConnectionResources::Response.new(self)
      end

      # Yield parsed server events until the remote peer closes the connection.
      def each
        return enum_for(__method__) unless block_given?

        with_read_lease do
          while (event = read_one)
            yield(event)
          end
        end

        self
      end

      # Receive and parse the next server event, or nil after a clean close.
      def receive
        with_read_lease { read_one }
      end

      # Validate, encode, and send a Responses client event.
      #
      # @return [nil]
      def send_event(event)
        assert_owner!
        assert_writable!
        payload = encode_client_event(event)
        encoded = JSON.generate(payload)
        record_stream_id!(payload[:stream_id] || payload["stream_id"])
        write_encoded(encoded)
      rescue OpenAI::Errors::ResponsesConnectionError,
        OpenAI::Errors::ResponsesClientEventError,
        OpenAI::Errors::ResponsesSendError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesClientEventError.new, cause: nil
      end

      # Close the connection.
      def close(code: 1000, reason: "")
        assert_owner!
        return if closed?
        return abort if poisoned?

        @state = :closing
        @socket.close(code: code, reason: reason)
        @state = :closed
        nil
      rescue OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        @state = :closed
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      # Abort without waiting for a close handshake.
      #
      # @api private
      def abort
        assert_owner!
        return if closed?

        @socket.abort
        @state = :closed
        nil
      rescue OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        @state = :closed
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      # @return [Boolean]
      def closed? = @state == :closed || @socket.closed?

      # @api private
      def poisoned? = @state == :poisoned

      private def read_one
        assert_owner!
        return nil if @state == :closed
        if @state == :poisoned
          raise(
            OpenAI::Errors::ResponsesConnectionError.new(
              url: @url,
              message: "Cannot read from a poisoned Responses WebSocket."
            )
          )
        end

        data = @socket.read
        if data.nil?
          @state = :closed
          return nil
        end

        parse_event(data.to_str)
      rescue OpenAI::Errors::ResponsesProtocolError
        @state = :poisoned
        raise
      rescue OpenAI::Errors::ResponsesConnectionError
        raise
      rescue StandardError
        @state = :poisoned
        raise OpenAI::Errors::ResponsesConnectionError.new(url: @url), cause: nil
      end

      private def parse_event(data)
        parsed = JSON.parse(data, symbolize_names: true)
        type = event_type(parsed)
        validate_inbound_stream_id!(parsed[:stream_id]) if parsed.key?(:stream_id)
        unless @server_event_names.key?(type.to_s)
          return OpenAI::Responses::UnknownServerEvent.new(data: parsed)
        end

        state = OpenAI::Internal::Type::Converter.new_coerce_state
        event = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Responses::ResponsesServerEvent,
          parsed,
          state: state
        )
        raise OpenAI::Errors::ResponsesProtocolError.new if coercion_error(state)

        if event.is_a?(OpenAI::Responses::ResponsesServerEvent::ResponseWsError) &&
            event.error.code == "websocket_connection_limit_reached"
          @state = :closing
        end

        event
      rescue OpenAI::Errors::ResponsesProtocolError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesProtocolError.new, cause: nil
      end

      private def encode_client_event(event)
        validate_event_tree!(event)
        normalized = if event.is_a?(Hash)
          OpenAI::Internal::Type::Unknown.dump(event, state: {can_retry: true})
        else
          OpenAI::Internal::Type::Converter.dump(OpenAI::Responses::ResponsesClientEvent, event)
        end

        raise OpenAI::Errors::ResponsesClientEventError.new unless normalized.is_a?(Hash)
        normalized = normalize_event_keys(normalized)
        reject_beta_event_fields!(normalized)

        type = normalized.key?(:type) ? normalized[:type] : normalized["type"]
        raise OpenAI::Errors::ResponsesClientEventError.new unless type.to_s == "response.create"

        %i[background multi_agent stream stream_options].each do |field|
          if normalized.key?(field) || normalized.key?(field.to_s)
            raise OpenAI::Errors::ResponsesClientEventError.new
          end
        end

        if semantic_key?(normalized, :stream_id)
          validate_outbound_stream_id!(semantic_value(normalized, :stream_id))
        end

        if semantic_key?(normalized, :generate) &&
            ![true, false].include?(semantic_value(normalized, :generate))
          raise OpenAI::Errors::ResponsesClientEventError.new
        end

        state = OpenAI::Internal::Type::Converter.new_coerce_state
        coerced = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Responses::ResponsesClientEvent,
          normalized,
          state: state
        )
        raise OpenAI::Errors::ResponsesClientEventError.new if coercion_error(state)

        payload = OpenAI::Internal::Type::Converter.dump(
          OpenAI::Responses::ResponsesClientEvent,
          coerced
        )
        payload = normalize_event_keys(payload)
        reject_beta_event_fields!(payload)
        reject_duplicate_semantic_keys!(payload)
        final_type = payload.key?(:type) ? payload[:type] : payload["type"]
        raise OpenAI::Errors::ResponsesClientEventError.new unless final_type.to_s == "response.create"

        if semantic_key?(payload, :stream_id)
          validate_outbound_stream_id!(semantic_value(payload, :stream_id))
        end

        if semantic_key?(payload, :generate) &&
            ![true, false].include?(semantic_value(payload, :generate))
          raise OpenAI::Errors::ResponsesClientEventError.new
        end

        payload
      rescue OpenAI::Errors::ResponsesClientEventError
        raise
      rescue StandardError
        raise OpenAI::Errors::ResponsesClientEventError.new, cause: nil
      end

      private def write_encoded(data)
        @socket.write(data)
        nil
      rescue StandardError
        @state = :poisoned
        raise OpenAI::Errors::ResponsesSendError.new(url: @url), cause: nil
      end

      private def with_read_lease
        acquired = false
        assert_owner!
        if @reading
          raise(
            OpenAI::Errors::ResponsesConnectionError.new(
              url: @url,
              message: "Responses WebSocket already has an active reader."
            )
          )
        end

        @reading = true
        acquired = true
        yield
      ensure
        @reading = false if acquired
      end

      private def assert_owner!
        return if @owner_thread == Thread.current.object_id

        raise(
          OpenAI::Errors::ResponsesConnectionError.new(
            url: @url,
            message: "Responses WebSocket connections are single-owner."
          )
        )
      end

      private def assert_writable!
        return if @state == :open && !@socket.closed?

        raise(
          OpenAI::Errors::ResponsesConnectionError.new(
            url: @url,
            message: "Cannot send on a closed Responses WebSocket."
          )
        )
      end

      private def record_stream_id!(stream_id)
        return if stream_id.nil? || @named_stream_ids.key?(stream_id)
        if @named_stream_ids.size >= MAX_NAMED_STREAM_IDS
          raise OpenAI::Errors::ResponsesClientEventError.new
        end

        @named_stream_ids[stream_id] = true
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

      private def reject_beta_event_fields!(payload)
        return unless payload.is_a?(Hash)
        raise OpenAI::Errors::ResponsesClientEventError.new if payload.key?(:multi_agent)

        reject_beta_input_items!(payload[:input]) if payload.key?(:input)
      end

      private def reject_beta_input_items!(value)
        items = value.is_a?(Array) ? value : [value]
        items.each do |item|
          next unless item.is_a?(Hash)

          beta_types = %i[agent_message multi_agent_call multi_agent_call_output]
          type = item[:type]
          if (type.is_a?(String) || type.is_a?(Symbol)) && beta_types.include?(type.to_sym)
            raise OpenAI::Errors::ResponsesClientEventError.new
          end

          raise OpenAI::Errors::ResponsesClientEventError.new if item.key?(:agent)
        end
      end

      private def semantic_key?(payload, key)
        payload.key?(key) || payload.key?(key.to_s)
      end

      private def semantic_value(payload, key)
        return payload.fetch(key) if payload.key?(key)

        payload.fetch(key.to_s)
      end

      private def validate_outbound_stream_id!(stream_id)
        return if stream_id.is_a?(String) && STREAM_ID.match?(stream_id)

        raise OpenAI::Errors::ResponsesClientEventError.new
      end

      private def validate_inbound_stream_id!(stream_id)
        return if stream_id.is_a?(String) && STREAM_ID.match?(stream_id)

        raise OpenAI::Errors::ResponsesProtocolError.new
      end

      private def event_type(event)
        unless event.is_a?(Hash)
          raise OpenAI::Errors::ResponsesProtocolError.new
        end

        type = event[:type]
        return type if type.is_a?(String) || type.is_a?(Symbol)

        raise OpenAI::Errors::ResponsesProtocolError.new
      end

      private def discriminator_values(union)
        union.variants.to_h do |variant|
          value = variant.fields.fetch(:type).fetch(:const)
          [value.to_s, true]
        end
      end

      private def coercion_error(state)
        return state[:error] if state[:error]
        return if state.fetch(:exactness).fetch(:no).zero?

        true
      end
    end
  end
end
