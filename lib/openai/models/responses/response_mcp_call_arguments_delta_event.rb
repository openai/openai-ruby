# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   A JSON string containing the partial update to the arguments for the MCP tool
        #   call.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The unique identifier of the MCP tool call item being processed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call_arguments.delta'.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.delta"]
        required :type, const: :"response.mcp_call_arguments.delta"

        # @!method initialize(delta:, item_id:, output_index:, sequence_number:, type: :"response.mcp_call_arguments.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent} for more
        #   details.
        #
        #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
        #   call.
        #
        #   @param delta [String] A JSON string containing the partial update to the arguments for the MCP tool ca
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.delta"] The type of the event. Always 'response.mcp_call_arguments.delta'.
      end
    end
  end
end
