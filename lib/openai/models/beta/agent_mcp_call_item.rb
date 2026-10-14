# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentMcpCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the MCP call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute arguments
        #   The arguments passed to the MCP tool.
        #
        #   @return [Object]
        required :arguments, OpenAI::Internal::Type::Unknown

        # @!attribute error
        #   The error returned by the MCP tool, if any.
        #
        #   @return [Object]
        required :error, OpenAI::Internal::Type::Unknown

        # @!attribute name
        #   The name of the MCP tool.
        #
        #   @return [String]
        required :name, String

        # @!attribute output
        #   The output returned by the MCP tool, if any.
        #
        #   @return [Object]
        required :output, OpenAI::Internal::Type::Unknown

        # @!attribute server_label
        #   The label of the MCP server.
        #
        #   @return [String]
        required :server_label, String

        # @!attribute status
        #   The status of the MCP tool call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `mcp_call`.
        #
        #   @return [Symbol, :mcp_call]
        required :type, const: :mcp_call

        # @!method initialize(id:, arguments:, error:, name:, output:, server_label:, status:, turn_id:, type: :mcp_call)
        #   A call to a tool on an MCP server.
        #
        #   @param id [String]
        #     The ID of the MCP call item.
        #
        #   @param arguments [Object]
        #     The arguments passed to the MCP tool.
        #
        #   @param error [Object]
        #     The error returned by the MCP tool, if any.
        #
        #   @param name [String]
        #     The name of the MCP tool.
        #
        #   @param output [Object]
        #     The output returned by the MCP tool, if any.
        #
        #   @param server_label [String]
        #     The label of the MCP server.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the MCP tool call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :mcp_call]
        #     The item type. Always `mcp_call`.
      end
    end
  end
end
