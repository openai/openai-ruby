# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Connects generated request and event bindings to the SDK-owned runtime.
    # Existing API helpers retain their more specific connection methods.
    #
    # @api private
    module Resource
      def connect(
        *path_arguments,
        query: {},
        websocket_base_url: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
        request = __websocket_request(*path_arguments, query: query.dup)
        base_url = websocket_base_url&.to_s&.dup&.freeze
        error_factory = -> (url:, **options) { BindingConnectionError.new(url: url, **options) }
        ConnectionManager
          .new(
            client: @client,
            transport: transport,
            transport_options: transport_options,
            default_transport: lambda do
              AsyncWebSocketTransport.new(
                product_name: "WebSocket",
                error_class: BindingConnectionError,
                error_factory: error_factory
              )
            end,
            connection_class: TypedConnection,
            connection_options: {client_event: __websocket_client_event, server_event: __websocket_server_event},
            request: lambda do |&request_block|
              @client.with_websocket_connection_request(
                request: request,
                websocket_base_url: base_url,
                options: request_options,
                &request_block
              )
            end,
            block_error_message: "A block is required to open a WebSocket.",
            abort_after_block: -> (_connection, error) { !error.nil? },
            transport_error_factory: -> (url:, error:) {
              status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
              BindingConnectionError.new(url: url, http_status: status)
            }
          )
          .open(&block)
      end
    end
  end
end
