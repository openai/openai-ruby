# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that is being processed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that is being processed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.in_progress'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.in_progress"]
        required :type, const: :"response.mcp_list_tools.in_progress"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.mcp_list_tools.in_progress")
        #   Emitted when the system is in the process of retrieving the list of available
        #   MCP tools.
        #
        #   @param item_id [String] The ID of the MCP tool call item that is being processed.
        #
        #   @param output_index [Integer] The index of the output item that is being processed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.in_progress"] The type of the event. Always 'response.mcp_list_tools.in_progress'.
      end
    end
  end
end
