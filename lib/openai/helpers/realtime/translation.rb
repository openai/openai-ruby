# frozen_string_literal: true

module OpenAI
  module Errors
    class TranslationConnectionError < OpenAI::Errors::WebSocketConnectionError
      private def default_message = "Realtime Translation WebSocket connection error."

      private def sanitized_error_url(url)
        sanitized = url.dup
        sanitized.user = nil if sanitized.respond_to?(:user=)
        sanitized.password = nil if sanitized.respond_to?(:password=)
        sanitized.query = nil if sanitized.respond_to?(:query=)
        sanitized.fragment = nil if sanitized.respond_to?(:fragment=)
        sanitized
      rescue ArgumentError, URI::Error
        URI("wss://invalid")
      end
    end

    class TranslationProtocolError < OpenAI::Errors::WebSocketProtocolError
      def initialize = super("Invalid Realtime Translation WebSocket event.")
    end
  end

  module Realtime
    # Future event data is accessible explicitly without leaking in diagnostics.
    class UnknownTranslationServerEvent < OpenAI::Realtime::UnknownServerEvent
      def inspect = "#<#{self.class} type=#{@type.inspect}>"
      alias to_s inspect

      private def freeze_json(value)
        pending = [value]
        visited = {}.compare_by_identity
        until pending.empty?
          item = pending.pop
          next if visited.key?(item)
          visited[item] = true
          case item
          when Hash
            item.each { |key, val| pending.push(key, val) }
          when Array
            pending.concat(item)
          end

          item.freeze
        end

        value
      end
    end

    # Opening does not send any events. session.close flushes remaining output;
    # read through session.closed before leaving the block to consume it.
    class TranslationConnection < OpenAI::WebSocket::Connection
      include OpenAI::WebSocket::Protocol

      # @api private
      def initialize(socket:, url:)
        super
        @poisoned = false
        @closed = false
        @server_event_types = OpenAI::Realtime::RealtimeTranslationServerEvent.variants.to_h do |variant|
          [variant.fields.fetch(:type).fetch(:const).to_s, variant]
        end

        @client_event_names = discriminator_values(OpenAI::Realtime::RealtimeTranslationClientEvent)
      end

      def send_event(event)
        send_raw(encode_client_event(event))
      end

      def closed? = @poisoned || @closed || super

      def close(code: 1000, reason: "")
        @poisoned || @closed ? abort : super
        @closed = true
        nil
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::TranslationConnectionError.new(url: @url), cause: nil
      end

      # @api private
      def abort
        super
        @closed = true
        nil
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::TranslationConnectionError.new(url: @url), cause: nil
      end

      private def write_text(text)
        super
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::TranslationConnectionError.new(url: @url), cause: nil
      end

      private def read_raw_message
        raise connection_error("Cannot read from a failed Realtime Translation WebSocket.") if @poisoned
        return nil if @closed
        text = super
        @closed = text.nil?
        text
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::TranslationConnectionError.new(url: @url), cause: nil
      end

      private def socket_closed?
        super
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::TranslationConnectionError.new(url: @url), cause: nil
      end

      private def encode_client_event(event)
        validate_client_tree!(event)
        union = OpenAI::Realtime::RealtimeTranslationClientEvent
        payload = OpenAI::Internal::Type::Converter.dump(union, event)
        type = payload[:type] || payload["type"] if payload.is_a?(Hash)
        raise ArgumentError unless (type.is_a?(String) || type.is_a?(Symbol)) && @client_event_names.key?(type.to_s)

        coerced = coerce_event(union, payload, outbound: true)
        serialized = OpenAI::Internal::Type::Converter.dump(union, coerced)
        validate_client_tree!(serialized, json_only: true)
        JSON.generate(serialized, max_nesting: false)
      rescue StandardError, SystemStackError
        raise ArgumentError, "Invalid Realtime Translation client event.", cause: nil
      end

      # A merged string-keyed JSON event and symbol-keyed override must not
      # silently change the command or the configuration that is sent.
      private def validate_client_tree!(event, json_only: false)
        visited = {}.compare_by_identity
        pending = [event]
        until pending.empty?
          item = pending.pop
          next if visited.key?(item)
          visited[item] = true
          case item
          when OpenAI::Internal::Type::BaseModel
            raise ArgumentError if json_only
            validate_model_constants!(item)
            pending << item.to_h
          when Hash
            names = {}
            item.each do |key, value|
              raise ArgumentError unless key.is_a?(String) || key.is_a?(Symbol)
              name = key.to_s
              raise ArgumentError if names.key?(name)
              names[name] = true
              pending << value
            end

          when Array
            pending.concat(item)
          when NilClass, TrueClass, FalseClass, String, Integer, Float, Symbol
            next
          else
            raise ArgumentError if json_only
          end
        end
      end

      private def validate_model_constants!(model)
        data = model.to_h
        model.class.fields.each do |name, field|
          const = field.fetch(:const)
          next if const == OpenAI::Internal::OMIT || !data.key?(name)
          actual = data.fetch(name)
          if const.is_a?(Symbol)
            raise ArgumentError unless (actual.is_a?(String) || actual.is_a?(Symbol)) && actual.to_s == const.to_s
          elsif actual != const
            raise ArgumentError
          end
        end
      end

      private def parse_event(data)
        parsed = JSON.parse(data, symbolize_names: true, max_nesting: false)
        type = event_type(parsed, message: "Realtime Translation server event must be an object with a string type")
        model = @server_event_types[type.to_s]
        unless model
          return OpenAI::Realtime::UnknownTranslationServerEvent.new(data: parsed)
        end

        # The converter copies unknown wire fields after known ones. A wire
        # key spelled like a renamed Ruby field must not overwrite typed data.
        model.fields.each do |name, field|
          raise ArgumentError if name != field.fetch(:api_name) && parsed.key?(name)
        end

        coerce_event(OpenAI::Realtime::RealtimeTranslationServerEvent, parsed)
      rescue StandardError, SystemStackError
        raise OpenAI::Errors::TranslationProtocolError.new, cause: nil
      end

      private def coerce_event(union, payload, outbound: false)
        state = OpenAI::Internal::Type::Converter.new_coerce_state(request_only: outbound)
        event = OpenAI::Internal::Type::Converter.coerce(union, payload, state: state)
        raise ArgumentError if state[:error] || !state.fetch(:exactness).fetch(:no).zero?
        ancestors = {}.compare_by_identity
        pending = [[event, false]]
        until pending.empty?
          value, exiting = pending.pop
          if exiting
            ancestors.delete(value)
            next
          end

          children = case value
          when OpenAI::Internal::Type::BaseModel
            data = value.to_h
            validate_model_constants!(value)
            value.class.fields.each do |name, field|
              const = field.fetch(:const)
              if field.fetch(:required) &&
                  field.fetch(:mode) != (outbound ? :coerce : :dump) &&
                  (!outbound || const == OpenAI::Internal::OMIT) &&
                  !data.key?(name)
                raise ArgumentError
              end
            end

            data.values
          when Hash
            value.values
          when Array
            value
          else
            next
          end

          raise ArgumentError if ancestors.key?(value)
          ancestors[value] = true
          pending << [value, true]
          children.each { |child| pending << [child, false] }
        end

        event
      end

      private def connection_error(message)
        OpenAI::Errors::TranslationConnectionError.new(url: @url, message: message)
      end
    end
  end

  module Helpers
    module Realtime
      module ClientExtension
        # @api private
        def with_translation_connection_request(model:, websocket_base_url: nil, options: nil, &block)
          websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
          query = {"model" => model.to_s.dup.freeze}.freeze
          build = lambda do |deadline|
            build_shared_websocket_connection_request(
              path: "realtime/translations",
              query: query,
              websocket_base_url: websocket_base_url,
              options: options,
              deadline: deadline,
              validate: -> (_) { validate_translation_websocket_request! },
              invalid_base_url_message: "websocket_base_url must be an absolute HTTP or WebSocket URL " \
                "without credentials, query, or fragment",
              malformed_base_url_message: "websocket_base_url is not a valid URL",
              preserve_base_url_cause: false,
              extra_query_message: "request_options extra_query is not supported for Realtime Translation WebSockets",
              max_retries_message: "request_options max_retries is not supported for Realtime Translation WebSockets",
              timeout_error: -> (url, _) { OpenAI::Errors::TranslationConnectionError.new(url: url) }
            )
          end

          with_websocket_connection_retry(
            error_class: OpenAI::Errors::TranslationConnectionError,
            build: build,
            &block
          )
        end

        private def validate_translation_websocket_request!
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Realtime Translation WebSockets"
          end

          if @provider_runtime
            raise OpenAI::Errors::Error, "Realtime Translation WebSockets are not supported by providers."
          end
        end
      end

      module Connections
        # Open a Translation socket with its own protocol. The server creates the
        # session; session.close requests a flush without closing this reader.
        def connect_translation(
          model:,
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime Translation WebSocket." unless block

          request = lambda do |&request_block|
            @client.with_translation_connection_request(
              model: model,
              websocket_base_url: websocket_base_url,
              options: request_options,
              &request_block
            )
          end

          default_transport = lambda do
            OpenAI::WebSocket::AsyncWebSocketTransport.new(
              product_name: "Realtime Translation",
              error_class: OpenAI::Errors::TranslationConnectionError,
              error_factory: -> (url:, message: nil, http_status: nil, **) {
                OpenAI::Errors::TranslationConnectionError.new(url: url, message: message, http_status: http_status)
              }
            )
          end

          OpenAI::WebSocket::ConnectionManager
            .new(
              transport: transport,
              transport_options: transport_options,
              default_transport: default_transport,
              connection_class: OpenAI::Realtime::TranslationConnection,
              request: request,
              block_error_message: "A block is required to open a Realtime Translation WebSocket.",
              abort_after_block: -> (_connection, pending_error) { !pending_error.nil? },
              transport_error_factory: -> (url:, error:) {
                status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
                OpenAI::Errors::TranslationConnectionError.new(url: url, http_status: status)
              }
            )
            .open(&block)
        end
      end
    end
  end
end
