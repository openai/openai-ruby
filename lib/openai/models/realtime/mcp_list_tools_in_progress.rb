# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class McpListToolsInProgress < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the MCP list tools item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `mcp_list_tools.in_progress`.
        #
        #   @return [Symbol, :"mcp_list_tools.in_progress"]
        required :type, const: :"mcp_list_tools.in_progress"

        # @!method initialize(event_id:, item_id:, type: :"mcp_list_tools.in_progress")
        #   Returned when listing MCP tools is in progress for an item.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the MCP list tools item.
        #
        #   @param type [Symbol, :"mcp_list_tools.in_progress"] The event type, must be `mcp_list_tools.in_progress`.
      end
    end
  end
end
