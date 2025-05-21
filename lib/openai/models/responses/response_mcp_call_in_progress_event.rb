# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallInProgressEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always 'response.mcp_call.in_progress'.
        #
        #   @return [Symbol, :"response.mcp_call.in_progress"]
        required :type, const: :"response.mcp_call.in_progress"

        # @!method initialize(item_id:, output_index:, type: :"response.mcp_call.in_progress")
        #   Emitted when an MCP tool call is in progress.
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param type [Symbol, :"response.mcp_call.in_progress"] The type of the event. Always 'response.mcp_call.in_progress'.
      end
    end
  end
end
