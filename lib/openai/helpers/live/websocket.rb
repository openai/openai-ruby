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
      include OpenAI::WebSocket::Protocol

      attr_reader :type, :data

      def initialize(data:)
        @type = data.fetch(:type) { data.fetch("type") }.to_sym
        @data = freeze_json(data)
        freeze
      end

      def to_h = @data
      def inspect = "#<#{self.class} type=#{@type.inspect}>"
      alias to_s inspect

    end

    # A transport-open primary connection. Startup is owned by the caller:
    # send session.start and observe session.started before further commands.
    # Use one reader at a time: receive, receive_raw, and each are alternatives.
    class Connection < OpenAI::WebSocket::TypedConnection
      # @api private
      def initialize(socket:, url:)
        super(socket: socket, url: url, client_event: client_event_type, server_event: server_event_type)
        @poisoned = false
        @closed = false
        @read_mutex = Mutex.new
      end

      private :parse_event

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

      # @api private
      def receive_raw
        with_read_lease { read_raw_message }
      end

      private def read_one
        data = read_raw_message
        return nil if data.nil?

        parse_event(data)
      end

      private def with_read_lease
        acquired = @read_mutex.try_lock
        unless acquired
          raise connection_error("Live WebSocket already has an active reader."), cause: nil
        end

        yield
      ensure
        @read_mutex.unlock if acquired
      end

      private def coerce_client_event(payload) = coerce_event(@client_event, payload, outbound: true)

      private def coerce(type, payload)
        event = coerce_event(type, payload)
        validate_event_tree!(event)
        event
      end

      private def client_event_error_message = "Invalid Live client event."

      private def unknown_server_event(payload) = OpenAI::Live::UnknownServerEvent.new(data: payload)

      private def protocol_error = OpenAI::Errors::LiveProtocolError.new

      private def transport_error = OpenAI::Errors::LiveConnectionError.new(url: @url)
      private def failed_read_message = "Cannot read from a failed Live WebSocket."

      private def connection_error(message)
        OpenAI::Errors::LiveConnectionError.new(url: @url, message: message)
      end

      private def client_event_type = OpenAI::Live::ClientEvent
      private def server_event_type = OpenAI::Live::ServerEvent
    end

    # Attached to an existing session; no new session.start handshake is sent.
    class SidebandConnection < Connection
      private def client_event_type = OpenAI::Live::SidebandClientEvent
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
        def with_live_websocket_connection_request(
          path: "live/sessions",
          query: {},
          websocket_base_url: nil,
          options: nil,
          &block
        )
          path = OpenAI::Internal::Util.interpolate_path(path).freeze
          query = query.dup.freeze
          websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
          build = lambda do |deadline|
            build_shared_websocket_connection_request(
              request: live.__websocket_request(query: query).merge(path: path),
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
            path: __websocket_request.fetch(:path),
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
          query: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Live WebSocket." unless block

          request = lambda do |&request_block|
            @client.with_live_websocket_connection_request(
              path: path,
              query: query,
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
  def connect(
    session_id,
    graceful_close: nil,
    websocket_base_url: nil,
    request_options: nil,
    transport: nil,
    transport_options: {},
    &block
  )
    unless graceful_close.nil? || graceful_close == true || graceful_close == false
      raise ArgumentError, "graceful_close must be true, false, or nil"
    end

    open_live_websocket(
      path: __websocket_request(session_id).fetch(:path),
      query: graceful_close.nil? ? {} : {"graceful_close" => graceful_close.to_s},
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
      path: __websocket_request(session_id).fetch(:path),
      connection_class: OpenAI::Live::ForkConnection,
      websocket_base_url: websocket_base_url,
      request_options: request_options,
      transport: transport,
      transport_options: transport_options,
      &block
    )
  end
end
