# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.failed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.failed"]
        required :type, const: :"response.mcp_list_tools.failed"

        # @!method initialize(type: :"response.mcp_list_tools.failed")
        #   Emitted when the attempt to list available MCP tools has failed.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.
      end
    end
  end
end
