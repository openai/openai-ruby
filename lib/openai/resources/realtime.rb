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

      # Open a server-side Realtime WebSocket. Pass exactly one of `model` to start a
      # conversation session, `intent: :transcription` to start transcription, or
      # `call_id` to attach a sideband connection to a WebRTC or SIP call. A block is
      # required and the socket is closed on every exit path.
      #
      # @param model [String, nil]
      # @param call_id [String, nil]
      # @param intent [Symbol, nil]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      # @param transport [#open, nil] An alternate WebSocket transport.
      # @param transport_options [Hash{Symbol=>Object}]
      # @yieldparam connection [OpenAI::Realtime::Connection]
      # @return [Object]
      def connect(
        model: nil,
        call_id: nil,
        intent: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
        raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

        targets = [model, call_id, intent].compact
        unless targets.one?
          message = "Pass exactly one of `model`, `call_id`, or `intent` when opening a Realtime WebSocket."
          raise ArgumentError, message
        end
        unless intent.nil? || intent == :transcription
          raise ArgumentError, "The only supported Realtime connection intent is `transcription`."
        end

        query, connection_class = connection_target(model: model, call_id: call_id, intent: intent)
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
      def connection_target(model:, call_id:, intent:)
        if model
          [{"model" => model}, OpenAI::Realtime::Connection]
        elsif call_id
          [{"call_id" => call_id}, OpenAI::Realtime::SidebandConnection]
        else
          [{"intent" => intent.to_s}, OpenAI::Realtime::TranscriptionConnection]
        end
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
