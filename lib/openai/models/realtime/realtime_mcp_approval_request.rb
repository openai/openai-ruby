# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpApprovalRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the approval request.
        #
        #   @return [String]
        required :id, String

        # @!attribute arguments
        #   A JSON string of arguments for the tool.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute name
        #   The name of the tool to run.
        #
        #   @return [String]
        required :name, String

        # @!attribute server_label
        #   The label of the MCP server making the request.
        #
        #   @return [String]
        required :server_label, String

        # @!attribute type
        #   The type of the item. Always `mcp_approval_request`.
        #
        #   @return [Symbol, :mcp_approval_request]
        required :type, const: :mcp_approval_request

        # @!method initialize(id:, arguments:, name:, server_label:, type: :mcp_approval_request)
        #   A Realtime item requesting human approval of a tool invocation.
        #
        #   @param id [String] The unique ID of the approval request.
        #
        #   @param arguments [String] A JSON string of arguments for the tool.
        #
        #   @param name [String] The name of the tool to run.
        #
        #   @param server_label [String] The label of the MCP server making the request.
        #
        #   @param type [Symbol, :mcp_approval_request] The type of the item. Always `mcp_approval_request`.
      end
    end
  end
end
