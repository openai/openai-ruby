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
        send_client_event(event)
      end

      # @api private
      def send_response_create(event)
        send_client_event(event, response_create: true)
      end

      private def send_client_event(event, response_create: false)
        assert_owner!
        raise connection_error("Cannot send on a closed Responses WebSocket.") if poisoned? || closed?

        encoded = begin
          generate_json(encode_client_event(event, response_create: response_create))
        rescue SystemStackError
          raise OpenAI::Errors::ResponsesClientEventError.new, cause: nil
        end

        write_encoded(encoded)
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
        parsed = parse_json(data)
        type = event_type(parsed, message: "Responses server event must be a JSON object")
        unless @server_event_names.key?(type.to_s)
          return OpenAI::Responses::UnknownServerEvent.new(data: parsed)
        end

        state = OpenAI::Internal::Type::Converter.new_coerce_state
        event = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Responses::ResponsesServerEvent,
          parsed,
          state: state
        )
        validate_wire_field_names!(event, parsed)
      rescue OpenAI::Errors::ResponsesProtocolError
        raise
      rescue StandardError, SystemStackError
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

      # @api private
      def encode_client_event(event, response_create: false)
        create_type = OpenAI::Responses::ResponsesClientEvent::ResponseCreate if response_create
        validate_event_tree!(event, target: create_type)
        payload = if response_create
          OpenAI::Internal::Type::Converter.dump(create_type, event)
        elsif event.is_a?(Hash)
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
        complete = false
        super
        complete = true
        nil
      rescue StandardError
        raise OpenAI::Errors::ResponsesSendError.new(url: @url), cause: nil
      ensure
        # Cancellation can bypass StandardError. Poison before another lane
        # can send, so normal cleanup cannot flush an uncertain write.
        @poisoned = true unless complete
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

      private def validate_event_tree!(value, target: nil)
        active = {}.compare_by_identity
        pending = [[value, false, target]]
        until pending.empty?
          value, exiting, target = pending.pop
          if exiting
            active.delete(value)
            next
          end

          # Use the serializer's selected type, so unknown extension hashes keep their
          # wire keys even when they resemble Ruby aliases in another model.
          while target.is_a?(OpenAI::Internal::Type::Union)
            target = target.variant_for_dump(value)
          end

          children = case value
          when OpenAI::Internal::Type::BaseModel
            data = value.to_h
            reject_duplicate_serialized_model_keys!(value.class, data)
            unless target.is_a?(Class) && target <= OpenAI::Internal::Type::BaseModel
              target = value.class
            end

            [[data, target]]
          when Hash
            reject_duplicate_semantic_keys!(value)
            if target.is_a?(Class) && target <= OpenAI::Internal::Type::BaseModel
              reject_duplicate_serialized_model_keys!(target, value, skip_coerce: true)
              value.map do |key, child|
                name = key.is_a?(String) ? key.to_sym : key
                field = target.known_fields[name]
                field = nil if field && field.fetch(:mode) == :coerce
                [child, field && field.fetch(:type_fn).call]
              end
            elsif target.is_a?(OpenAI::Internal::Type::HashOf)
              item_type = target.item_type
              value.values.map { [_1, item_type] }
            else
              value.values.map { [_1, nil] }
            end

          when Array
            item_type = target.is_a?(OpenAI::Internal::Type::ArrayOf) ? target.item_type : nil
            value.map { [_1, item_type] }
          else
            next
          end

          guard_cycle!(value, active)
          pending << [value, true, nil]
          children.reverse_each { |child, child_type| pending << [child, false, child_type] }
        end

        nil
      end

      private def reject_duplicate_serialized_model_keys!(model, data, skip_coerce: false)
        serialized_keys = data.keys.filter_map do |key|
          name = key.is_a?(String) ? key.to_sym : key
          field = model.known_fields[name]
          next if skip_coerce && field && field.fetch(:mode) == :coerce
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
        return value unless value.is_a?(Hash) || value.is_a?(Array)

        result = value.is_a?(Hash) ? {} : []
        copies = {}.compare_by_identity
        copies[value] = result
        pending = [[value, result]]
        until pending.empty?
          source, destination = pending.pop
          entries = source.is_a?(Hash) ? source.each_pair : source.each_with_index.lazy.map { |item, index|
            [index, item]
          }
          entries.each do |key, item|
            if item.is_a?(Hash) || item.is_a?(Array)
              unless copies.key?(item)
                copies[item] = item.is_a?(Hash) ? {} : []
                pending << [item, copies.fetch(item)]
              end

              item = copies.fetch(item)
            end

            normalized_key = key.is_a?(String) ? key.to_sym : key
            destination[normalized_key] = item
          end
        end

        result
      end

      private def connection_error(message)
        OpenAI::Errors::ResponsesConnectionError.new(url: @url, message: message)
      end

    end
  end
end
