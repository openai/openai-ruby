# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that failed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that failed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.failed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.failed"]
        required :type, const: :"response.mcp_list_tools.failed"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.mcp_list_tools.failed")
        #   Emitted when the attempt to list available MCP tools has failed.
        #
        #   @param item_id [String] The ID of the MCP tool call item that failed.
        #
        #   @param output_index [Integer] The index of the output item that failed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.
      end
    end
  end
end
