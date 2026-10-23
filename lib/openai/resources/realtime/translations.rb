# frozen_string_literal: true

require_relative "../../helpers/websocket/typed_resource"

module OpenAI
  module Resources
    class Realtime
      class Translations
        include OpenAI::WebSocket::TypedResource

        # @api private
        def __websocket_request(query: {})
          {method: :get, path: "realtime/translations", query: query, security: {bearer_auth: true}}
        end

        # @api private
        def __websocket_client_event
          OpenAI::Models::Realtime::RealtimeTranslationClientEvent
        end

        # @api private
        def __websocket_server_event
          OpenAI::Models::Realtime::RealtimeTranslationServerEvent
        end

        # @return [OpenAI::Resources::Realtime::Translations::ClientSecrets]
        attr_reader :client_secrets

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @client_secrets = OpenAI::Resources::Realtime::Translations::ClientSecrets.new(client: client)
        end
      end
    end
  end
end
