# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallArgumentsDelta < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The JSON-encoded arguments delta.
        #
        #   @return [String]
        required :delta, String

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
        #   The event type, must be `response.mcp_call_arguments.delta`.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.delta"]
        required :type, const: :"response.mcp_call_arguments.delta"

        # @!attribute obfuscation
        #   If present, indicates the delta text was obfuscated.
        #
        #   @return [String, nil]
        optional :obfuscation, String, nil?: true

        # @!method initialize(delta:, event_id:, item_id:, output_index:, response_id:, obfuscation: nil, type: :"response.mcp_call_arguments.delta")
        #   Returned when MCP tool call arguments are updated during response generation.
        #
        #   @param delta [String] The JSON-encoded arguments delta.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the MCP tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param obfuscation [String, nil] If present, indicates the delta text was obfuscated.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.delta"] The event type, must be `response.mcp_call_arguments.delta`.
      end
    end
  end
end
