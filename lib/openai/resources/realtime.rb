# frozen_string_literal: true

require_relative "../helpers/websocket/typed_resource"

module OpenAI
  module Resources
    class Realtime
      include OpenAI::WebSocket::TypedResource

      # @api private
      def __websocket_request(query: {})
        {method: :get, path: "realtime", query: query, security: {bearer_auth: true}}
      end

      # @api private
      def __websocket_client_event
        OpenAI::Models::Realtime::RealtimeClientEvent
      end

      # @api private
      def __websocket_server_event
        OpenAI::Models::Realtime::RealtimeServerEvent
      end

      # @return [OpenAI::Resources::Realtime::ClientSecrets]
      attr_reader :client_secrets

      # @return [OpenAI::Resources::Realtime::Calls]
      attr_reader :calls

      # @return [OpenAI::Resources::Realtime::Translations]
      attr_reader :translations

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
