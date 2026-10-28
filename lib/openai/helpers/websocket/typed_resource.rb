# frozen_string_literal: true

require_relative "resource"

module OpenAI
  module WebSocket
    # Supplies the generic signature contract for generated event bindings.
    # Connection lifecycle and event handling are implemented by Resource.
    #
    # @api private
    module TypedResource
      include Resource
    end
  end
end
