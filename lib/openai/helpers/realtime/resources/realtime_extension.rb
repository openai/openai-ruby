# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Ruby-native WebSocket entry point layered onto the generated Realtime
      # resource. Generated HTTP accessors remain owned by the generated class.
      module Connections
        # Open a server-side Realtime WebSocket. A block is required and the
        # socket is closed on every exit path.
        def connect(
          model:,
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
          open_realtime_connection(
            query: {"model" => model},
            role: :realtime,
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

        # Attach a server-side control WebSocket to an existing WebRTC or SIP call.
        def connect_to_call(
          call_id:,
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
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block
          unless call_id.is_a?(String) && !call_id.empty?
            raise ArgumentError, "`call_id` must be a non-empty String."
          end

          open_realtime_connection(
            query: {"call_id" => call_id},
            role: :realtime_call,
            connection_class: OpenAI::Realtime::SidebandConnection,
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

        # Open a dedicated server-side Realtime transcription WebSocket. The
        # transcription model is selected in the subsequent session update.
        def connect_transcription(
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
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

          open_realtime_connection(
            query: {"intent" => "transcription"},
            role: :realtime_transcription,
            connection_class: OpenAI::Realtime::Connection,
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

        private def open_realtime_connection(
          query:,
          role:,
          websocket_base_url:,
          request_options:,
          transport:,
          transport_options:,
          reconnect:,
          max_reconnect_attempts:,
          max_queue_bytes:,
          on_reconnected:,
          on_reconnecting:,
          connection_class: OpenAI::Realtime::Connection,
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block
          OpenAI::Realtime::Recovery.validate_options!(
            reconnect: reconnect,
            role: role,
            max_reconnect_attempts: max_reconnect_attempts,
            max_queue_bytes: max_queue_bytes,
            on_reconnected: on_reconnected,
            on_reconnecting: on_reconnecting
          )
          request = OpenAI::WebSocket::RecoveryRequest.new(query: query, options: request_options) if reconnect
          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            query: query,
            websocket_base_url: websocket_base_url,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options,
            connection_class: connection_class,
            recovery_request: request
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
              request_options: request,
              connection_factory: -> (socket, url) { connection_class.new(socket: socket, url: url, recovery: socket) }
            )
            .open(&block)
        end
      end
    end
  end
end

OpenAI::Resources::Realtime.include(OpenAI::Helpers::Realtime::Connections)
