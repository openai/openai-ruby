# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.failed'.
        #
        #   @return [Symbol, :"response.mcp_call.failed"]
        required :type, const: :"response.mcp_call.failed"

        # @!method initialize(sequence_number:, type: :"response.mcp_call.failed")
        #   Emitted when an MCP tool call has failed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_call.failed"] The type of the event. Always 'response.mcp_call.failed'.
      end
    end
  end
end
