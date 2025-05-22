# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.in_progress'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.in_progress"]
        required :type, const: :"response.mcp_list_tools.in_progress"

        # @!method initialize(sequence_number:, type: :"response.mcp_list_tools.in_progress")
        #   Emitted when the system is in the process of retrieving the list of available
        #   MCP tools.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.in_progress"] The type of the event. Always 'response.mcp_list_tools.in_progress'.
      end
    end
  end
end
