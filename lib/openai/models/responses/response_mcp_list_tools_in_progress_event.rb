# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.in_progress'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.in_progress"]
        required :type, const: :"response.mcp_list_tools.in_progress"

        # @!method initialize(type: :"response.mcp_list_tools.in_progress")
        #   Emitted when the system is in the process of retrieving the list of available
        #   MCP tools.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.in_progress"] The type of the event. Always 'response.mcp_list_tools.in_progress'.
      end
    end
  end
end
