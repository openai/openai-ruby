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
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            query: {"model" => model},
            websocket_base_url: websocket_base_url,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options
          )
          manager.open(&block)
        end

        # Attach a server-side control WebSocket to an existing WebRTC or SIP call.
        def connect_to_call(
          call_id:,
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block
          unless call_id.is_a?(String) && !call_id.empty?
            raise ArgumentError, "`call_id` must be a non-empty String."
          end

          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            query: {"call_id" => call_id},
            websocket_base_url: websocket_base_url,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options,
            connection_class: OpenAI::Realtime::SidebandConnection
          )
          manager.open(&block)
        end

        # Open a dedicated server-side Realtime transcription WebSocket. The
        # transcription model is selected in the subsequent session update.
        def connect_transcription(
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            query: {"intent" => "transcription"},
            websocket_base_url: websocket_base_url,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options
          )
          manager.open(&block)
        end
      end
    end
  end
end

OpenAI::Resources::Realtime.include(OpenAI::Helpers::Realtime::Connections)
