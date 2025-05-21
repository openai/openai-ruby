# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallCompletedEvent < OpenAI::Internal::Type::BaseModel
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

        # @!method initialize(sequence_number:, type: :"response.mcp_call.completed")
        #   Emitted when an MCP tool call has completed successfully.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.
      end
    end
  end
end
