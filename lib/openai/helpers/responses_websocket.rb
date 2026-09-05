# frozen_string_literal: true

# Responses WebSocket mode is a custom SDK runtime layered on generated
# Responses protocol models. Generated HTTP resources remain generator-owned.
require_relative "responses_websocket/errors"
require_relative "responses_websocket/unknown_server_event"
require_relative "responses_websocket/connection_resources"
require_relative "responses_websocket/connection"
require_relative "responses_websocket/connection_manager"
require_relative "responses_websocket/transports/async_websocket"
require_relative "responses_websocket/client_extension"
require_relative "responses_websocket/resources/responses_extension"
