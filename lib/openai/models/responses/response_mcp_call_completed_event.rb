# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that completed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that completed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.completed'.
        #
        #   @return [Symbol, :"response.mcp_call.completed"]
        required :type, const: :"response.mcp_call.completed"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.mcp_call.completed")
        #   Emitted when an MCP tool call has completed successfully.
        #
        #   @param item_id [String] The ID of the MCP tool call item that completed.
        #
        #   @param output_index [Integer] The index of the output item that completed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.
      end
    end
  end
end
