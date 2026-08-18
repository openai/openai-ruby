# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallInProgress < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the MCP tool call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The event type, must be `response.mcp_call.in_progress`.
        #
        #   @return [Symbol, :"response.mcp_call.in_progress"]
        required :type, const: :"response.mcp_call.in_progress"

        # @!method initialize(event_id:, item_id:, output_index:, type: :"response.mcp_call.in_progress")
        #   Returned when an MCP tool call has started and is in progress.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the MCP tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param type [Symbol, :"response.mcp_call.in_progress"] The event type, must be `response.mcp_call.in_progress`.
      end
    end
  end
end
