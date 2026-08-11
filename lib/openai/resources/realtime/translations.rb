# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      # Dedicated Realtime translation endpoints and WebSocket connections.
      class Translations
        # @return [OpenAI::Resources::Realtime::Translations::ClientSecrets]
        attr_reader :client_secrets

        # @return [OpenAI::Resources::Realtime::Translations::Calls]
        attr_reader :calls

        # Open a typed translation WebSocket connection.
        #
        # @param model [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        # @param transport [#open, nil]
        # @param transport_options [Hash{Symbol=>Object}]
        # @yieldparam connection [OpenAI::Realtime::TranslationConnection]
        # @return [Object]
        def connect(model:, request_options: nil, transport: nil, transport_options: {}, &block)
          raise ArgumentError, "A block is required to open a Realtime WebSocket." unless block

          manager = OpenAI::Realtime::ConnectionManager.new(
            client: @client,
            path: "realtime/translations",
            query: {"model" => model},
            connection_class: OpenAI::Realtime::TranslationConnection,
            transport: transport,
            request_options: request_options,
            transport_options: transport_options
          )
          manager.open(&block)
        end

        # @api private
        def initialize(client:)
          @client = client
          @client_secrets = ClientSecrets.new(client: client)
          @calls = Calls.new(client: client)
        end
      end
    end
  end
end
