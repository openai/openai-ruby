# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.failed'.
        #
        #   @return [Symbol, :"response.mcp_call.failed"]
        required :type, const: :"response.mcp_call.failed"

        # @!method initialize(type: :"response.mcp_call.failed")
        #   Emitted when an MCP tool call has failed.
        #
        #   @param type [Symbol, :"response.mcp_call.failed"] The type of the event. Always 'response.mcp_call.failed'.
      end
    end
  end
end
