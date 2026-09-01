# frozen_string_literal: true

# Internal, product-neutral WebSocket runtime shared by SDK WebSocket APIs.
# Product helpers keep their event models and resource facades separate.
require_relative "websocket/errors"
require_relative "websocket/connection"
require_relative "websocket/connection_manager"
require_relative "websocket/protocol"
require_relative "websocket/async_websocket_transport"
require_relative "websocket/client_request"
