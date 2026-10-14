# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallFailed < OpenAI::Internal::Type::BaseModel
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
        #   The event type, must be `response.mcp_call.failed`.
        #
        #   @return [Symbol, :"response.mcp_call.failed"]
        required :type, const: :"response.mcp_call.failed"

        # @!method initialize(event_id:, item_id:, output_index:, type: :"response.mcp_call.failed")
        #   Returned when an MCP tool call has failed.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the MCP tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param type [Symbol, :"response.mcp_call.failed"] The event type, must be `response.mcp_call.failed`.
      end
    end
  end
end
