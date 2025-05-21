# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.failed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.failed"]
        required :type, const: :"response.mcp_list_tools.failed"

        # @!method initialize(sequence_number:, type: :"response.mcp_list_tools.failed")
        #   Emitted when the attempt to list available MCP tools has failed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.
      end
    end
  end
end
