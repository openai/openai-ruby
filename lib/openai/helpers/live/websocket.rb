# frozen_string_literal: true

module OpenAI
  module Errors
    class LiveConnectionError < OpenAI::Errors::WebSocketConnectionError
      private def default_message = "Live WebSocket connection error."

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

    class LiveProtocolError < OpenAI::Errors::WebSocketProtocolError
      def initialize = super("Invalid Live WebSocket event.")
    end
  end

  module Live
    # A future server event retains its raw data, but routine diagnostics do not
    # render potentially sensitive audio, transcript, or session fields.
    class UnknownServerEvent
      attr_reader :type, :data

      def initialize(data:)
        @type = data.fetch(:type) { data.fetch("type") }.to_sym
        @data = freeze_json(data)
        freeze
      end

      def to_h = @data
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

    # A transport-open primary connection. Startup is owned by the caller:
    # send session.start and observe session.started before further commands.
    class Connection < OpenAI::WebSocket::Connection
      include OpenAI::WebSocket::Protocol

      # @api private
      def initialize(socket:, url:)
        super
        @poisoned = false
        @closed = false
        @server_event_names = discriminator_values(server_event_type)
        @client_event_names = discriminator_values(client_event_type)
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
        raise OpenAI::Errors::LiveConnectionError.new(url: @url), cause: nil
      end

      # @api private
      def abort
        super
        @closed = true
        nil
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::LiveConnectionError.new(url: @url), cause: nil
      end

      private def write_text(text)
        super
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::LiveConnectionError.new(url: @url), cause: nil
      end

      private def read_raw_message
        raise connection_error("Cannot read from a failed Live WebSocket.") if @poisoned
        return nil if @closed
        text = super
        @closed = text.nil?
        text
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::LiveConnectionError.new(url: @url), cause: nil
      end

      private def socket_closed?
        super
      rescue StandardError
        @poisoned = true
        raise OpenAI::Errors::LiveConnectionError.new(url: @url), cause: nil
      end

      private def encode_client_event(event)
        validate_event_tree!(event)
        payload = OpenAI::Internal::Type::Converter.dump(client_event_type, event)
        type = payload[:type] || payload["type"] if payload.is_a?(Hash)
        raise ArgumentError unless (type.is_a?(String) || type.is_a?(Symbol)) && @client_event_names.key?(type.to_s)

        coerced = coerce_event(client_event_type, payload, outbound: true)
        serialized = OpenAI::Internal::Type::Converter.dump(client_event_type, coerced)
        validate_event_tree!(serialized, json_only: true)
        JSON.generate(serialized, max_nesting: false)
      rescue StandardError, SystemStackError
        raise ArgumentError, "Invalid Live client event.", cause: nil
      end

      private def parse_event(data)
        parsed = JSON.parse(data, symbolize_names: true, max_nesting: false)
        type = event_type(parsed, message: "Live server event must be an object with a string type")
        unless @server_event_names.key?(type.to_s)
          return OpenAI::Live::UnknownServerEvent.new(data: parsed)
        end

        event = coerce_event(server_event_type, parsed)
        validate_event_tree!(event)
        event
      rescue StandardError, SystemStackError
        raise OpenAI::Errors::LiveProtocolError.new, cause: nil
      end

      private def coerce_event(union, payload, outbound: false)
        state = OpenAI::Internal::Type::Converter.new_coerce_state(request_only: outbound)
        event = OpenAI::Internal::Type::Converter.coerce(union, payload, state: state)
        raise ArgumentError if state[:error] || !state.fetch(:exactness).fetch(:no).zero?
        pending = [event]
        until pending.empty?
          value = pending.pop
          case value
          when OpenAI::Internal::Type::BaseModel
            value.class.fields.each do |name, field|
              if field.fetch(:required) &&
                  field.fetch(:mode) != (outbound ? :coerce : :dump) &&
                  (!outbound || field.fetch(:const) == OpenAI::Internal::OMIT) &&
                  !value.to_h.key?(name)
                raise ArgumentError
              end
            end

            pending.concat(value.to_h.values)
          when Hash
            pending.concat(value.values)
          when Array
            pending.concat(value)
          end
        end

        event
      end

      private def validate_event_tree!(event, json_only: false)
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
            raise ArgumentError if json_only
            data = value.to_h
            keys = {}
            data.each do |key, val|
              name = key.is_a?(String) ? key.to_sym : key
              field = value.class.known_fields[name]
              serialized_name = field ? field.fetch(:api_name).to_s : name.to_s
              raise ArgumentError if keys.key?(serialized_name)
              keys[serialized_name] = true
              next unless field
              const = field.fetch(:const)
              next if const == OpenAI::Internal::OMIT
              if const.is_a?(Symbol)
                raise ArgumentError unless (val.is_a?(String) || val.is_a?(Symbol)) && val.to_s == const.to_s
              elsif val != const
                raise ArgumentError
              end
            end

            [data]
          when Hash
            keys = {}
            value.each_key do |key|
              raise ArgumentError unless key.is_a?(String) || key.is_a?(Symbol)
              name = key.to_s
              raise ArgumentError if keys.key?(name)
              keys[name] = true
            end

            value.values
          when Array
            value
          when NilClass, TrueClass, FalseClass, String, Integer, Float, Symbol
            next
          else
            raise ArgumentError if json_only
            next
          end

          raise ArgumentError if ancestors.key?(value)
          ancestors[value] = true
          pending << [value, true]
          children.each { |child| pending << [child, false] }
        end
      end

      private def connection_error(message)
        OpenAI::Errors::LiveConnectionError.new(url: @url, message: message)
      end

      private def client_event_type = OpenAI::Live::ClientEvent
      private def server_event_type = OpenAI::Live::ServerEvent
    end

    # Attached to an existing session; no new session.start handshake is sent.
    class SidebandConnection < Connection
      # @api private
      def initialize(socket:, url:)
        super
        @client_event_names = @client_event_names.except("session.start", "session.input_audio.append")
      end
    end

    # Caller-driven startup using overrides for an eligible stored session.
    class ForkConnection < Connection
      def send_event(event)
        if event.is_a?(OpenAI::Live::SessionStartEvent)
          raise ArgumentError, "Invalid Live client event."
        end

        super
      end

      private def client_event_type = OpenAI::Live::ForkClientEvent
      private def server_event_type = OpenAI::Live::ForkServerEvent

      private def coerce_event(union, payload, outbound: false)
        event = super
        if outbound && event.is_a?(OpenAI::Live::ForkSessionStartEvent)
          overrides = event.session.to_h
          raise ArgumentError if overrides.key?(:model) || overrides.key?(:client)
        end

        event
      end
    end
  end

  module Helpers
    module LiveWebSocket
      # @api private
      module ClientExtension
        include OpenAI::WebSocket::ClientRequest

        # @api private
        def with_live_websocket_connection_request(path: "live/sessions", websocket_base_url: nil, options: nil, &block)
          path = OpenAI::Internal::Util.interpolate_path(path).freeze
          websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
          build = lambda do |deadline|
            build_shared_websocket_connection_request(
              path: path,
              query: {},
              websocket_base_url: websocket_base_url,
              options: options,
              deadline: deadline,
              validate: -> (_) { validate_live_websocket_request! },
              invalid_base_url_message: "websocket_base_url must be an absolute HTTP or WebSocket URL " \
                "without credentials, query, or fragment",
              malformed_base_url_message: "websocket_base_url is not a valid URL",
              preserve_base_url_cause: false,
              extra_query_message: "request_options extra_query is not supported for Live WebSocket connections",
              max_retries_message: "request_options max_retries is not supported for Live WebSocket connections",
              timeout_error: -> (url, _) { OpenAI::Errors::LiveConnectionError.new(url: url) }
            )
          end

          with_websocket_connection_retry(
            error_class: OpenAI::Errors::LiveConnectionError,
            build: build,
            &block
          )
        end

        private def validate_live_websocket_request!
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Live WebSocket connections"
          end

          if @provider_runtime
            raise OpenAI::Errors::Error, "Live WebSocket connections are not supported by providers."
          end
        end
      end

      module Connections
        # Open a primary Live WebSocket; the model is supplied in session.start,
        # not in the URL. This opens only the transport, never starts a session.
        def connect(websocket_base_url: nil, request_options: nil, transport: nil, transport_options: {}, &block)
          open_live_websocket(
            path: "live/sessions",
            connection_class: OpenAI::Live::Connection,
            websocket_base_url: websocket_base_url,
            request_options: request_options,
            transport: transport,
            transport_options: transport_options,
            &block
          )
        end

        private def open_live_websocket(
          path:,
          connection_class:,
          websocket_base_url:,
          request_options:,
          transport:,
          transport_options:,
          &block
        )
          raise ArgumentError, "A block is required to open a Live WebSocket." unless block

          request = lambda do |&request_block|
            @client.with_live_websocket_connection_request(
              path: path,
              websocket_base_url: websocket_base_url,
              options: request_options,
              &request_block
            )
          end

          default_transport = lambda do
            OpenAI::WebSocket::AsyncWebSocketTransport.new(
              product_name: "Live",
              error_class: OpenAI::Errors::LiveConnectionError,
              error_factory: -> (url:, message: nil, http_status: nil, **) {
                OpenAI::Errors::LiveConnectionError.new(url: url, message: message, http_status: http_status)
              }
            )
          end

          OpenAI::WebSocket::ConnectionManager
            .new(
              transport: transport,
              transport_options: transport_options,
              default_transport: default_transport,
              connection_class: connection_class,
              request: request,
              block_error_message: "A block is required to open a Live WebSocket.",
              abort_after_block: -> (_connection, pending_error) { !pending_error.nil? },
              transport_error_factory: -> (url:, error:) {
                status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
                OpenAI::Errors::LiveConnectionError.new(url: url, http_status: status)
              }
            )
            .open(&block)
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::LiveWebSocket::ClientExtension)
OpenAI::Resources::Live.include(OpenAI::Helpers::LiveWebSocket::Connections)

class OpenAI::Resources::Live::Sideband
  include OpenAI::Helpers::LiveWebSocket::Connections

  # Attach to an eligible existing session with its selected observer credentials.
  # The service may replay recent events; attachment does not start a new session.
  def connect(session_id, websocket_base_url: nil, request_options: nil, transport: nil, transport_options: {}, &block)
    open_live_websocket(
      path: ["live/sessions/%1$s/attach", session_id],
      connection_class: OpenAI::Live::SidebandConnection,
      websocket_base_url: websocket_base_url,
      request_options: request_options,
      transport: transport,
      transport_options: transport_options,
      &block
    )
  end
end

class OpenAI::Resources::Live::Forks
  include OpenAI::Helpers::LiveWebSocket::Connections

  # Open a fork of an eligible stored recording. Send session.start with
  # session: {} to inherit the recording, then wait for session.started.
  def connect(session_id, websocket_base_url: nil, request_options: nil, transport: nil, transport_options: {}, &block)
    open_live_websocket(
      path: ["live/sessions/%1$s/fork", session_id],
      connection_class: OpenAI::Live::ForkConnection,
      websocket_base_url: websocket_base_url,
      request_options: request_options,
      transport: transport,
      transport_options: transport_options,
      &block
    )
  end
end
