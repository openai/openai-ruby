# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The partial update to the arguments for the MCP tool call.
        #
        #   @return [Object]
        required :delta, OpenAI::Internal::Type::Unknown

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

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.arguments_delta'.
        #
        #   @return [Symbol, :"response.mcp_call.arguments_delta"]
        required :type, const: :"response.mcp_call.arguments_delta"

        # @!method initialize(delta:, item_id:, output_index:, type: :"response.mcp_call.arguments_delta")
        #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
        #   call.
        #
        #   @param delta [Object] The partial update to the arguments for the MCP tool call.
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param type [Symbol, :"response.mcp_call.arguments_delta"] The type of the event. Always 'response.mcp_call.arguments_delta'.
      end
    end
  end
end
