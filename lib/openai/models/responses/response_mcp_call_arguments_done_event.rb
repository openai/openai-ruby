# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   A JSON string containing the finalized arguments for the MCP tool call.
        #
        #   @return [String]
        required :arguments, String

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
        #   The type of the event. Always 'response.mcp_call_arguments.done'.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.done"]
        required :type, const: :"response.mcp_call_arguments.done"

        # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, type: :"response.mcp_call_arguments.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent} for more details.
        #
        #   Emitted when the arguments for an MCP tool call are finalized.
        #
        #   @param arguments [String] A JSON string containing the finalized arguments for the MCP tool call.
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.done"] The type of the event. Always 'response.mcp_call_arguments.done'.
      end
    end
  end
end
