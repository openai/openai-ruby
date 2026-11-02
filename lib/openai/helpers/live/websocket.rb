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
    # Only one receive call may read or decode at a time. Iteration releases
    # the read before yielding an event to the caller.
    class Connection < OpenAI::WebSocket::TypedConnection
      include OpenAI::WebSocket::RecoveryConnection
      # @api private
      def initialize(socket:, url:, recovery: nil)
        super(socket: socket, url: url, client_event: client_event_type, server_event: server_event_type)
        @recovery = recovery
        @poisoned = false
        @closed = false
        @read_mutex = Mutex.new
      end

      private :parse_event

      def receive
        with_read_lease { read_one }
      end

      # @api private
      def receive_raw
        with_read_lease { read_raw_message }
      end

      private def read_one
        return receive_recovered_event if @recovery

        data = read_raw_message
        return nil if data.nil?

        parse_event(data)
      end

      private def with_read_lease
        return yield if @recovery&.restoring_owner?

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

      private def recovery_transport_error(error)
        return error if error.is_a?(OpenAI::Errors::LiveConnectionError)

        OpenAI::Errors::LiveConnectionError.new(url: @url, cause: error)
      end

      private def recovery_application_progress?(event)
        return false unless super
        return true unless event.type == :"response.event"

        nested = event.event
        type = (nested[:type] || nested["type"]).to_s
        @recovery_response_event_names ||= discriminator_values(OpenAI::Responses::ResponseStreamEvent)
        @recovery_response_event_names.key?(type) &&
          positive_recovery_event_type?(type) &&
          !failed_recovery_response?(nested[:response] || nested["response"])
      end

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
          recovery_request: nil,
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
              recovery_request: recovery_request,
              validate: -> (_) { validate_live_websocket_request! },
              invalid_base_url_message: "websocket_base_url must be an absolute HTTP or WebSocket URL " \
                "without credentials, query, or fragment",
              malformed_base_url_message: "websocket_base_url is not a valid URL",
              preserve_base_url_cause: false,
              extra_query_message: "request_options extra_query is not supported for Live WebSocket connections",
              max_retries_message: "request_options max_retries is not supported for Live WebSocket connections",
              timeout_error: -> (url, cause) {
                OpenAI::Errors::LiveConnectionError.new(url: url, cause: recovery_request ? cause : nil)
              }
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
        def connect(
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          reconnect: false,
          max_reconnect_attempts: 5,
          max_queue_bytes: 0,
          on_reconnected: nil,
          on_reconnecting: nil,
          &block
        )
          open_live_websocket(
            path: __websocket_request.fetch(:path),
            connection_class: OpenAI::Live::Connection,
            role: :live,
            websocket_base_url: websocket_base_url,
            request_options: request_options,
            transport: transport,
            transport_options: transport_options,
            reconnect: reconnect,
            max_reconnect_attempts: max_reconnect_attempts,
            max_queue_bytes: max_queue_bytes,
            on_reconnected: on_reconnected,
            on_reconnecting: on_reconnecting,
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
          role: :live,
          reconnect: false,
          max_reconnect_attempts: 5,
          max_queue_bytes: 0,
          on_reconnected: nil,
          on_reconnecting: nil,
          &block
        )
          raise ArgumentError, "A block is required to open a Live WebSocket." unless block

          OpenAI::Realtime::Recovery.validate_options!(
            reconnect: reconnect,
            role: role,
            max_reconnect_attempts: max_reconnect_attempts,
            max_queue_bytes: max_queue_bytes,
            on_reconnected: on_reconnected,
            on_reconnecting: on_reconnecting
          )
          if reconnect
            path = OpenAI::Internal::Util.interpolate_path(path).dup.freeze
            websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
          end

          selected = OpenAI::WebSocket::RecoveryRequest.new(query: query, options: request_options) if reconnect
          error_factory = lambda do |url:, message: nil, http_status: nil, cause: nil|
            OpenAI::Errors::LiveConnectionError.new(
              url: url,
              message: message,
              http_status: http_status,
              cause: reconnect ? cause : nil
            )
          end

          request = lambda do |&request_block|
            @client.with_live_websocket_connection_request(
              path: path,
              query: selected ? selected.query : query,
              websocket_base_url: websocket_base_url,
              options: selected ? selected.options : request_options,
              recovery_request: selected,
              &request_block
            )
          end

          default_transport = lambda do
            OpenAI::WebSocket::AsyncWebSocketTransport.new(
              product_name: "Live",
              error_class: OpenAI::Errors::LiveConnectionError,
              error_factory: error_factory
            )
          end

          manager = OpenAI::WebSocket::ConnectionManager
            .new(
              client: @client,
              transport: transport,
              transport_options: transport_options,
              default_transport: default_transport,
              connection_class: connection_class,
              request: request,
              block_error_message: "A block is required to open a Live WebSocket.",
              abort_after_block: -> (_connection, pending_error) { !pending_error.nil? },
              transport_error_factory: -> (url:, error:) {
                next error if reconnect && error.is_a?(OpenAI::Errors::LiveConnectionError)

                status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
                error_factory.call(url: url, http_status: status, cause: error)
              }
            )
          return manager.open(&block) unless reconnect

          OpenAI::Realtime::Recovery
            .new(
              manager: manager,
              max_reconnect_attempts: max_reconnect_attempts,
              max_queue_bytes: max_queue_bytes,
              on_reconnected: on_reconnected,
              on_reconnecting: on_reconnecting,
              role: role,
              request_options: selected,
              connection_factory: -> (socket, url) { connection_class.new(socket: socket, url: url, recovery: socket) },
              connection_error_class: OpenAI::Errors::LiveConnectionError,
              reconnect_error_class: OpenAI::Errors::WebSocketReconnectError,
              queue_error_class: OpenAI::Errors::WebSocketQueueFullError
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
    reconnect: false,
    max_reconnect_attempts: 5,
    max_queue_bytes: 0,
    on_reconnected: nil,
    on_reconnecting: nil,
    &block
  )
    unless graceful_close.nil? || graceful_close == true || graceful_close == false
      raise ArgumentError, "graceful_close must be true, false, or nil"
    end

    open_live_websocket(
      path: __websocket_request(session_id).fetch(:path),
      query: graceful_close.nil? ? {} : {"graceful_close" => graceful_close.to_s},
      connection_class: OpenAI::Live::SidebandConnection,
      role: :live_sideband,
      websocket_base_url: websocket_base_url,
      request_options: request_options,
      transport: transport,
      transport_options: transport_options,
      reconnect: reconnect,
      max_reconnect_attempts: max_reconnect_attempts,
      max_queue_bytes: max_queue_bytes,
      on_reconnected: on_reconnected,
      on_reconnecting: on_reconnecting,
      &block
    )
  end
end

class OpenAI::Resources::Live::Forks
  include OpenAI::Helpers::LiveWebSocket::Connections

  # Open a fork of an eligible stored recording. Send session.start with
  # session: {} to inherit the recording, then wait for session.started.
  def connect(
    session_id,
    websocket_base_url: nil,
    request_options: nil,
    transport: nil,
    transport_options: {},
    reconnect: false,
    max_reconnect_attempts: 5,
    max_queue_bytes: 0,
    on_reconnected: nil,
    on_reconnecting: nil,
    &block
  )
    open_live_websocket(
      path: __websocket_request(session_id).fetch(:path),
      connection_class: OpenAI::Live::ForkConnection,
      role: :live_fork,
      websocket_base_url: websocket_base_url,
      request_options: request_options,
      transport: transport,
      transport_options: transport_options,
      reconnect: reconnect,
      max_reconnect_attempts: max_reconnect_attempts,
      max_queue_bytes: max_queue_bytes,
      on_reconnected: on_reconnected,
      on_reconnecting: on_reconnecting,
      &block
    )
  end
end
