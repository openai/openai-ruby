# frozen_string_literal: true

module OpenAI
  module Realtime
    # Low-level Translation socket. The caller owns session state and reads;
    # managed Translation finish/drain semantics are deliberately separate.
    class TranslationSocketConnection < OpenAI::WebSocket::TypedConnection
      include OpenAI::WebSocket::RecoveryConnection

      # @api private
      def initialize(socket:, url:, recovery: nil)
        super(
          socket: socket,
          url: url,
          client_event: OpenAI::Realtime::RealtimeTranslationClientEvent,
          server_event: OpenAI::Realtime::RealtimeTranslationServerEvent
        )
        @recovery = recovery
      end
    end
  end

  module Helpers
    module Realtime
      # @api private
      module TranslationSockets
        def connect(
          query: {},
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
          raise ArgumentError, "A block is required to open a WebSocket." unless block
          OpenAI::Realtime::Recovery.validate_options!(
            reconnect: reconnect,
            role: :translation,
            max_reconnect_attempts: max_reconnect_attempts,
            max_queue_bytes: max_queue_bytes,
            on_reconnected: on_reconnected,
            on_reconnecting: on_reconnecting
          )
          selected = OpenAI::WebSocket::RecoveryRequest.new(query: query, options: request_options) if reconnect
          base_url = websocket_base_url&.to_s&.dup&.freeze
          error_factory = lambda do |url:, **options|
            OpenAI::WebSocket::BindingConnectionError.new(url: url, preserve_cause: reconnect, **options)
          end

          manager = OpenAI::WebSocket::ConnectionManager.new(
            client: @client,
            transport: transport,
            transport_options: transport_options,
            default_transport: lambda do
              OpenAI::WebSocket::AsyncWebSocketTransport.new(
                product_name: "WebSocket",
                error_class: OpenAI::WebSocket::BindingConnectionError,
                error_factory: error_factory
              )
            end,
            connection_class: OpenAI::Realtime::TranslationSocketConnection,
            request: lambda do |&request_block|
              @client.with_websocket_connection_request(
                request: __websocket_request(query: selected ? selected.query : query.dup),
                websocket_base_url: base_url,
                options: selected ? selected.options : request_options,
                recovery_request: selected,
                &request_block
              )
            end,
            block_error_message: "A block is required to open a WebSocket.",
            abort_after_block: -> (_connection, error) { !error.nil? },
            transport_error_factory: lambda do |url:, error:|
              next error if reconnect && error.is_a?(OpenAI::WebSocket::BindingConnectionError)

              status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
              error_factory.call(url: url, http_status: status, cause: error)
            end
          )
          return manager.open(&block) unless reconnect

          OpenAI::Realtime::Recovery
            .new(
              manager: manager,
              max_reconnect_attempts: max_reconnect_attempts,
              max_queue_bytes: max_queue_bytes,
              on_reconnected: on_reconnected,
              on_reconnecting: on_reconnecting,
              role: :translation,
              request_options: selected,
              connection_factory: -> (socket, url) {
                OpenAI::Realtime::TranslationSocketConnection.new(socket: socket, url: url, recovery: socket)
              },
              connection_error_class: OpenAI::WebSocket::BindingConnectionError,
              reconnect_error_class: OpenAI::Errors::WebSocketReconnectError,
              queue_error_class: OpenAI::Errors::WebSocketQueueFullError
            )
            .open(&block)
        end
      end
    end
  end
end

OpenAI::Resources::Realtime::Translations.include(OpenAI::Helpers::Realtime::TranslationSockets)
