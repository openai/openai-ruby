# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.completed'.
        #
        #   @return [Symbol, :"response.mcp_call.completed"]
        required :type, const: :"response.mcp_call.completed"

        # @!method initialize(type: :"response.mcp_call.completed")
        #   Emitted when an MCP tool call has completed successfully.
        #
        #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.
      end
    end
  end
end
