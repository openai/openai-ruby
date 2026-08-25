# frozen_string_literal: true

# Realtime is a custom SDK runtime layered on generated protocol models and
# resources. Keeping its implementation under helpers prevents API generation
# from rewriting custom transport, lifecycle, and convenience code.
require_relative "realtime/conversation_item_variant_resolver"
require_relative "realtime/unknown_server_event"
require_relative "realtime/errors"
require_relative "realtime/connection_resources"
require_relative "realtime/connection"
require_relative "realtime/sideband_connection"
require_relative "realtime/connection_manager"
require_relative "realtime/transports/async_websocket"
require_relative "realtime/client_extension"
require_relative "realtime/resources/realtime_extension"
