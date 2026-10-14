# frozen_string_literal: true

module OpenAI
  module Helpers
    module ResponsesWebSocket
      # Ruby-native WebSocket entry point layered onto the generated Responses resource.
      module Connections
        def connect(
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Responses WebSocket." unless block

          manager = OpenAI::Responses::ConnectionManager.new(
            client: @client,
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

OpenAI::Resources::Responses.include(OpenAI::Helpers::ResponsesWebSocket::Connections)
