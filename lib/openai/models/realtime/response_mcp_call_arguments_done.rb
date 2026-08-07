# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallArgumentsDone < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   The final JSON-encoded arguments string.
        #
        #   @return [String]
        required :arguments, String

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

        # @!attribute response_id
        #   The ID of the response.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event type, must be `response.mcp_call_arguments.done`.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.done"]
        required :type, const: :"response.mcp_call_arguments.done"

        # @!method initialize(arguments:, event_id:, item_id:, output_index:, response_id:, type: :"response.mcp_call_arguments.done")
        #   Returned when MCP tool call arguments are finalized during response generation.
        #
        #   @param arguments [String] The final JSON-encoded arguments string.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the MCP tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.done"] The event type, must be `response.mcp_call_arguments.done`.
      end
    end
  end
end
