# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that produced this output.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that was processed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.completed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.completed"]
        required :type, const: :"response.mcp_list_tools.completed"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.mcp_list_tools.completed")
        #   Emitted when the list of available MCP tools has been successfully retrieved.
        #
        #   @param item_id [String] The ID of the MCP tool call item that produced this output.
        #
        #   @param output_index [Integer] The index of the output item that was processed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.completed"] The type of the event. Always 'response.mcp_list_tools.completed'.
      end
    end
  end
end
