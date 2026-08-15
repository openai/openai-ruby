# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Ruby-native WebSocket entry points layered onto the generated Realtime
      # resource. Generated HTTP accessors remain owned by the generated class.
      module Connections
        # @return [OpenAI::Resources::Realtime::Translations]
        attr_reader :translations

        # Open a server-side Realtime conversation WebSocket. A block is required and
        # the socket is closed on every exit path.
        def connect(model:, request_options: nil, transport: nil, transport_options: {}, &block)
          open_connection(
            query: {"model" => model},
            connection_class: OpenAI::Realtime::Connection,
            request_options: request_options,
            transport: transport,
            transport_options: transport_options,
            &block
          )
        end

        # Attach a sideband WebSocket to an existing WebRTC or SIP call.
        def connect_to_call(
          call_id:,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          open_connection(
            query: {"call_id" => call_id},
            connection_class: OpenAI::Realtime::SidebandConnection,
            request_options: request_options,
            transport: transport,
            transport_options: transport_options,
            &block
          )
        end

        # Open a dedicated Realtime transcription WebSocket.
        def connect_transcription(
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          open_connection(
            query: {"intent" => "transcription"},
            connection_class: OpenAI::Realtime::TranscriptionConnection,
            request_options: request_options,
            transport: transport,
            transport_options: transport_options,
            &block
          )
        end

        private def open_connection(
          query:,
          connection_class:,
          request_options:,
          transport:,
          transport_options:,
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            path: "realtime",
            query: query,
            connection_class: connection_class,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options
          )
          manager.open(&block)
        end
      end

      # Adds custom Realtime sub-resources without replacing generated initialization.
      module ResourceInitialization
        def initialize(client:)
          super
          @translations = OpenAI::Resources::Realtime::Translations.new(client: client)
        end
      end
    end
  end
end

OpenAI::Resources::Realtime.include(OpenAI::Helpers::Realtime::Connections)
OpenAI::Resources::Realtime.prepend(OpenAI::Helpers::Realtime::ResourceInitialization)
