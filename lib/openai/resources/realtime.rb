# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      # @return [OpenAI::Resources::Realtime::ClientSecrets]
      attr_reader :client_secrets

      # @return [OpenAI::Resources::Realtime::Calls]
      attr_reader :calls

      # @return [OpenAI::Resources::Realtime::Translations]
      attr_reader :translations

      # Open a server-side Realtime conversation WebSocket. A block is required and
      # the socket is closed on every exit path.
      #
      # @param model [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      # @param transport [#open, nil] An alternate WebSocket transport.
      # @param transport_options [Hash{Symbol=>Object}]
      # @yieldparam connection [OpenAI::Realtime::Connection]
      # @return [Object]
      def connect(
        model:,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
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
      #
      # @param call_id [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      # @param transport [#open, nil] An alternate WebSocket transport.
      # @param transport_options [Hash{Symbol=>Object}]
      # @yieldparam connection [OpenAI::Realtime::SidebandConnection]
      # @return [Object]
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
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      # @param transport [#open, nil] An alternate WebSocket transport.
      # @param transport_options [Hash{Symbol=>Object}]
      # @yieldparam connection [OpenAI::Realtime::TranscriptionConnection]
      # @return [Object]
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

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @client_secrets = OpenAI::Resources::Realtime::ClientSecrets.new(client: client)
        @calls = OpenAI::Resources::Realtime::Calls.new(client: client)
        @translations = OpenAI::Resources::Realtime::Translations.new(client: client)
      end
    end
  end
end
