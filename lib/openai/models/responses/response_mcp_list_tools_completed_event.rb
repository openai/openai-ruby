# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.completed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.completed"]
        required :type, const: :"response.mcp_list_tools.completed"

        # @!method initialize(sequence_number:, type: :"response.mcp_list_tools.completed")
        #   Emitted when the list of available MCP tools has been successfully retrieved.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.completed"] The type of the event. Always 'response.mcp_list_tools.completed'.
      end
    end
  end
end
